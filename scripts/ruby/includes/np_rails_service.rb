# frozen_string_literal: false

require "#{File.expand_path(__dir__)}/np_service.rb"
require "#{File.expand_path(__dir__)}/kenv.rb"

class NpRailsService < NpService
  def prepare_service
    return unless on_local_kraken?

    super
    prepare_local_service
  end

  def override_envs(environment)
    environment ? { 'RAILS_ENV' => environment } : {}
  end

  def prepare_local_service; end

  def start_command
    # "npsrun -a #{name} -e development -c bin/start_web_server.sh"
    "railsstartservice"
  end

  def run_command(cmd, environment: 'development')
    Kenv.exec_with_env(cmd, path: path, env_path: env_dst_path, override_envs: override_envs(environment), app_name: name)
  end

  def run_connect_command(environment: 'development')
    Kenv.exec_with_env(nil, path: path, env_path: env_dst_path, override_envs: override_envs(environment), app_name: name)
  end
end
