# frozen_string_literal: false

require 'optparse'
require 'open3'
require 'uri/http'

begin
  require 'highline'
  require 'colored'
rescue LoadError
  puts <<~XXX
    To run this utility:
      gem install 'highline'
      gem install 'colored'
  XXX
  exit(1)
end

require_relative 'np_paths'
require_relative 'np_service'
require_relative 'np_rails_service'
require_relative 'np_node_service'
require_relative 'np_convox_service'
require_relative 'np_docker_service'
require_relative 'np_remote_service'
require_relative 'op_php_service'
require_relative 'convox_util'

class OpBase < NpPaths
  attr_accessor :option_parser, :debug, :opts_write, :opts_delete, :opts_np_app_name, :opts_np_app

  LOCATION_KRAKEN_LOCAL = 'kraken'.freeze
  LOCATION_CONVOX_LOCAL = 'convox-local'.freeze
  LOCATION_OFFICE_CONVOX = 'remote-convox-office'.freeze
  LOCATION_APACHE_LOCAL = 'apache-local'.freeze

  ################ OP SERVERS ###################
  def load_op_severs_config
    if File.exist?("#{path_local_settings}/op-servers-config.rb")
      require "#{path_local_settings}/op-servers-config.rb"
    elsif File.exist?("#{path_templates}/op-servers-config.rb")
      require "#{path_templates}/op-servers-config.rb"
    else
      exit_with_error("Could not find 'op-servers-config.rb' either in local-settings or templates")
    end
  end

  def servers
    load_op_severs_config unless defined?(OpServers) == 'constant'

    OpServers::SERVERS
  end

  def hostnames
    load_op_severs_config unless defined?(OpServers) == 'constant'

    OpServers::HOSTNAMES
  end
  ################ OP SERVERS ###################

  ################ NP SERVICES ###################
  def load_np_services_config
    return if defined?(NpServices)

    if File.exist?("#{path_local_settings}/np-services-config.rb")
      require "#{path_local_settings}/np-services-config.rb"
    elsif File.exist?("#{path_templates}/np-services-config.rb")
      require "#{path_templates}/np-services-config.rb"
    else
      exit_with_error("Could not find 'np-services-config.rb' either in local-settings or templates")
    end
  end

  def np_services
    load_np_services_config unless defined?(NpServices) == 'constant'

    @_np_services ||= NpService::APP_LOCATIONS \
      .map { |type, location| NpServices::NP_SERVICES[type].map  { |s| s.merge(location: location) } }
      .flatten
      .each_with_object({}) do |service_data, hash|
        name = dashed_app_name(service_data[:name]).to_sym
        exit_with_error "App #{name} can't have two locations: #{hash[name].location.green}#{' and '.red}#{service_data[:location].green}" if hash[name]

        hash[name] = build_service_from_config(service_data)
      end
      .merge(mysql: local_mysql_app)

    @_np_services
  end

  def local_mysql_app
    @_local_mysql_app ||= begin
      NpDockerService.new(
        name: 'mysql', gitname: nil, type: 'mysql', port: '3306',
        path: "#{path_kraken}/superlocal", location: 'local-docker'
      )
    end
  end

  def local_kraken_np_services
    @_local_kraken_np_services ||= np_services.map { |_k, v| v.on_local_kraken? ? v : nil }.compact
  end

  def local_convox_np_services
    @_local_convox_np_services ||= np_services.map { |_k, v| v.on_local_convox? ? v : nil }.compact
  end

  def convox_office_server?
    @_conf_type ||= begin
      load_np_services_config
      NpServices::CONFING_TYPE
    end

    @_conf_type == NpServices::CONFIG_TYPE_COVOX_OFFICE
  end

  def convox_local_rack
    @_convox_local_rack ||= begin
      load_np_services_config
      NpServices::LOCAL_CONVOX_RACK
    end
  end

  def convox_racks
    @_convox_racks ||= begin
      load_np_services_config
      NpServices::CONVOX_RACKS
    end
  end

  def convox_local_dev_rack?
    convox_local_rack == 'dev'
  end
  ################ NP SERVICES ###################

  protected

  def hyphenated_app_name(name)
    name.to_s.gsub(/[ _]+/, '-').downcase
  end

  ################ OP SERVERS ###################
  def op_deploy_config(name)
    name = dashed_app_name(name).to_sym
    @_op_deploy_config ||= {}
    @_op_deploy_config[name] ||= begin
      res = servers[name].clone
      res[:hostnames].map! { |h| hostnames[h] }
      res
    end
    @_op_deploy_config[name]
  end

  def server_name_from_hostname(hostname)
    @__hostname_inverse ||= hostnames.invert

    @__hostname_inverse[hostname]
  end

  def ssh_config(name)
    name = dashed_app_name(name).to_sym
    @_ssh_config ||= {}
    @_ssh_config[name] ||= begin
      conf = servers.map { |_k, v| v[:hostnames].include?(name) ? v : nil }.compact.first

      throw "Config for #{name} not found" if conf.nil?
      conf.merge(hostname: hostnames[name])
          .slice(:user, :key, :hostname, :dst, :port, :deploy_path, :zip_name)
    end
    @_ssh_config[name]
  end
  ################ OP SERVERS ###################

  ################ NP SERVICES ###################
  def np_service_config(name, exit_on_fail = false)
    # TODO: remove dietbet support
    name = name.gsub(/dietbet-/, 'wb-') unless name.eql?("dietbet-game-service")
    
    config = np_services[dashed_app_name(name).to_sym]
    exit_with_error "NP service config for #{name} not found" unless config || !exit_on_fail

    config
  end

  def np_service_app_name(name)
    np_service_config(name).name
  end

  def np_service_path(name)
    np_service_config(name).path
  end

  def np_service_location(name)
    np_service_config(name).location
  end

  def np_service_port(name)
    np_service_config(name).port
  end

  def np_service_is_on_local_convox?(name)
    np_service_config(name).on_local_convox?
  end

  def np_service_is_on_local_apache?(name)
    np_service_config(name).on_local_apache?
  end

  def np_service_is_ruby(name)
    np_service_config(name).type_is_ruby?
  end

  def np_service_is_node(name)
    np_service_config(name).type_is_node?
  end

  ################ NP SERVICES ###################

  def add_debug_option(opts)
    opts.on('-z', '--debug', 'Optional: load pry') do |_x|
      puts 'Loaded pry in debug mode'.red
      require 'pry'
      self.debug = true
    end
  end

  def add_help_option(opts)
    opts.on('-h', '--help', 'Prints this help') do
      puts opts
      exit
    end
  end

  def add_op_app_option(opts)
    opts.on('-a', '--app=A', 'Application Name (website name)') do |x|
      self.opts_op_app = x
    end
  end

  def add_write_option(opts, message)
    opts.on('-w', '--write', message) do |_x|
      self.opts_write = true
    end
  end

  def add_delete_option(opts, message)
    opts.on('-d', '--delete', message) do |_x|
      self.opts_delete = true
    end
  end

  def add_print_option(opts, message)
    opts.on('-p', '--print', message) do |_x|
      self.opts_print = true
    end
  end

  def add_np_app_option(opts)
    app = np_service_config(File.basename(Dir.getwd))
    if app
      self.opts_np_app = app
      self.opts_np_app_name = app.name
    end

    opts.on('-a', '--app=A', 'Required, NP application name') do |x|
      x = 'wb-auth-service' if x == 'auth'
      pattern = Regexp.new(x)

      app = (np_services.find { |_k, v| pattern =~ v.name } || [])[1]
      exit_with_error "Did not find any NP services for pattern '*#{x}*'" unless app
      self.opts_np_app = app
      self.opts_np_app_name = app.name
    end
  end

  def exec_command(cmd, message: nil)
    puts "Running command: '#{cmd}'" if debug
    puts message  if message

    cmd.gsub("'", "\\\\'")
    `#{cmd}`
  end

  ##
  # Executes command in interactive mode, outputting stout to screen and returning true or false
  #
  def exec_ic_command(cmd, exit_on_fail: true, message: nil)
    puts message if message
    result = system cmd
    if result
      result
    else
      warn "FAIL: '#{cmd}', exiting: #{exit_on_fail}"
      exit 1 if exit_on_fail
    end
  end

  def exec_bash_command(cmd, exit_on_fail: true, message: nil)
    cmd = "/bin/bash -ic '#{cmd}'"
    exec_ic_command(cmd, exit_on_fail: exit_on_fail, message: message)
  end

  def exit_with_error(msg)
    puts "Error: #{msg}".red
    exit(1)
  end

  def show_help
    puts option_parser.nil? ? HELP : option_parser
  end

  def run_ssh_command(user, host, key, command, port = 22)
    puts "Connecting to #{user}@#{host}".green
    response = exec_command("ssh -i #{key} #{user}@#{host} -p #{port} -t '#{command}'")
    print response.green
  end

  def checkout_app(name:, path:)
    name = hyphenated_app_name(name)

    gitname = name == 'kraken' ? 'kraken' : np_service_config(name).gitname

    exec_command "cd #{path} && git clone git@github.com:wbetterdev/#{gitname}.git #{name}",
                 message: "Cloning #{name} from git"
  end

  def np_service_domain(name, location: nil)
    name = hyphenated_app_name(name)

    transformations = {
      'dietbet-game-service' => 'dietbet',
      'stepbet-game-service' => 'stepbet'
    }
    domain = transformations[name] || name

    apply_location_to_np_service_domain("#{domain}.convox.local", name, location)
  end

  def np_service_convox_domain(name)
    convox_local_dev_rack? ? "web.#{name}.dev.convox" : "web.#{name}.convox"
  end

  def get_service_external_domain(name, variant: nil, location: nil)
    name = hyphenated_app_name(name)
    urls = \
      if NpServices::USE_STAGING_DOMAIN_LOCALLY
        {
          'wb-auth-service'       => { 'default' => 'accounts-staging.waybetter.com' },
          'wb-graphql-service'    => { 'default' => 'graphql-staging.waybetter.com', 'ninja' => 'graphql-staging.waybetter.ninja' },
          'wb-hub'                => { 'default' => 'hub-staging.waybetter.com'},
          'wb-admin-auth-service' => { 'default' => 'admin-auth-staging.waybetter.ninja' },
          'wb-admin-web'          => { 'default' => 'www-staging.waybetter.ninja' }
        }
      else
        {
          'wb-auth-service'       => { 'default' => 'accounts-local.waybetterdev.com' },
          'wb-graphql-service'    => { 'default' => 'graphql-local.waybetterdev.com', 'ninja' => 'graphql-local.waybetter.ninja' },
          'wb-hub'                => { 'default' => 'hub-local.waybetterdev.com'},
          'wb-admin-auth-service' => { 'default' => 'admin-auth-local.waybetter.ninja' },
          'wb-admin-web'          => { 'default' => 'www-local.waybetter.ninja' }
        }
      end
    variant ||= 'default'
    url = urls[name][variant]
    return unless url

    apply_location_to_np_service_domain(url, name, location)
  end

  def apply_location_to_np_service_domain(domain, name, location = nil)
    if convox_office_server?
      domain_part = 'office'
    else
      location ||= np_service_location(name)
      domain_part = location == LOCATION_OFFICE_CONVOX ? 'office' : 'local'
    end

    domain.gsub(/(local|office)/, domain_part)
  end

  def find_local_ip
    @_find_local_ip ||= exec_command('hostname -I | egrep -oh 192.168.[0-9]+.[0-9]+').split("\n").first
  end

  ################ CONVOX ###################
  def convox_ready?
    @_convox_ready ||= exec_command("cd #{@path} && convox apps").match(/RELEASE/)
  end

  def kubernetes_ready?
    exec_command('microk8s.status').match(/microk8s is running/)
  end

  def start_kubernetes
    exec_command('microk8s.start && microk8s.status --wait-ready')
  end

  def convox_app_path(convox_app)
    path = np_service_path(convox_app) unless convox_app == 'mysql'
    path || "#{@path}/#{convox_app}"
  end

  def convox_app_path_exists?(convox_app)
    File.directory?(convox_app_path(convox_app))
  end

  def create_convox_app(convox_app)
    exec_command([
      "cd #{convox_app_path(convox_app)}",
      "convox apps create #{convox_app}",
      "#{path_ruby_bin}/kmd-local refresh-env -- local #{convox_app} no-confirm",
      "#{path_ruby_bin}/kmd-local refresh-yml -- local #{convox_app} no-confirm"
    ].join(' && '))
  end

  def delete_convox_app(convox_app)
    exec_command("convox apps delete #{convox_app}")
  end
  ################ CONVOX ###################

  private

  def build_service_from_config(service_data)
    path = service_data[:name]
    path = path.gsub('wb-', 'dietbet/dietbet-') if  path =~ /graph|bil|user|/ 
    service_data[:path] ||= "#{path_wb_services}/#{path}"
    
    case service_data[:location]
    when LOCATION_CONVOX_LOCAL
      NpConvoxService.new(**service_data)
    when LOCATION_KRAKEN_LOCAL
      case service_data[:type]
      when 'ruby'
        NpRailsService.new(**service_data)
      when 'node'
        NpNodeService.new(**service_data)
      end
    when LOCATION_OFFICE_CONVOX
      NpRemoteService.new(**service_data)
    when LOCATION_APACHE_LOCAL
      OpPhpService.new(**service_data)
    else
      NpService.new(**service_data)
    end
  end

  def dashed_app_name(name)
    name.to_s.gsub(/[ -]+/, '_').downcase
  end
end
