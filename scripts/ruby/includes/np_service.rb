# frozen_string_literal: false

class NpService < NpPaths
  attr_accessor :name, :gitname, :type, :port, :path, :location, :domain

  LOCATION_KRAKEN_LOCAL = 'kraken'.freeze
  LOCATION_CONVOX_LOCAL = 'convox-local'.freeze
  LOCATION_OFFICE_CONVOX = 'remote-convox-office'.freeze
  LOCATION_APACHE_LOCAL = 'apache-local'.freeze
  LOCATION_STAGING_REMOTE = 'staging-remote'.freeze

  APP_LOCATIONS = {
    local_kraken: LOCATION_KRAKEN_LOCAL,
    local_convox: LOCATION_CONVOX_LOCAL,
    remote_convox_office: LOCATION_OFFICE_CONVOX,
    local_apache: LOCATION_APACHE_LOCAL,
    remote_staging: LOCATION_STAGING_REMOTE
  }.freeze

  def initialize(name:, path:, location:, type: nil, port: nil, gitname: nil, domain: nil)
    @name = name
    @gitname = gitname
    @path = path
    @location = location
    @type = type
    @port = port
    @domain = domain
  end

  def on_local_kraken?
    @location.eql?(LOCATION_KRAKEN_LOCAL)
  end

  def on_local_convox?
    @location.eql?(LOCATION_CONVOX_LOCAL)
  end

  def on_convox_office?
    @location.eql?(LOCATION_OFFICE_CONVOX)
  end

  def on_local_apache?
    @location.eql?(LOCATION_APACHE_LOCAL)
  end

  def on_remote_staging?
    @location.eql?(LOCATION_STAGING_REMOTE)
  end

  def type_is_ruby?
    @type.eql?('ruby')
  end

  def type_is_node?
    @type.eql?('node')
  end

  def type_is_php?
    @type.eql?('php')
  end

  def service_is_installed?
    true
  end

  def prepare_service
    checkout_from_git unless path.nil? || Dir.exist?(path)
  end

  def parent_path
    File.expand_path('..', path)
  end

  def checkout_from_git
    exec_command(
      "cd #{parent_path} && git clone git@github.com:wbetterdev/#{gitname}.git #{name}",
      message: "Cloning #{name} from git"
    )
  end

  def exec_command(cmd, message: nil)
    puts "Running command: '#{cmd}'"
    puts message  if message

    cmd.gsub("'", "\\\\'")
    `#{cmd}`
  end

  def convox_yml_path
    "#{path}/convox.yml"
  end

  def env_src_path
    "#{path_local_settings}/convox-env/#{name}.env.local"
  end

  def env_dst_path
    "#{path_local_settings}/convox-env/generated/#{name}.env.local"
  end

  def exit_with_error(msg)
    puts "Error: #{msg}".red
    exit(1)
  end
end
