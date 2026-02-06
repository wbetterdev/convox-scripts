# frozen_string_literal: false

require_relative 'np_service'

class NpNodeService < NpService
  def prepare_service
    return unless on_local_kraken?

    super
    prepare_local_service
  end

  def override_envs(environment)
    environment.eql?('development') ? { 'RAILS_ENV' => 'development' } : {}
  end

  def prepare_local_service
    # copy .env file if wb-admin-web since it cannot use system env vars
    exec_command("cp #{env_dst_path} #{path}/.env") if name.eql?('wb-admin-web')
  end

  def start_command
    # "npsrun -a #{name} -e development -c \"nvm use && nvm ls && npm start\""
    'npmstartservice'
  end

  def run_command(cmd, environment: 'development')
    Kenv.exec_with_env(cmd, path: path, env_path: env_dst_path, override_envs: override_envs(environment),
                            app_name: name)
  end

  def run_connect_command(environment: 'development')
    Kenv.exec_with_env(nil, path: path, env_path: env_dst_path, override_envs: override_envs(environment),
                            app_name: name)
  end
end
