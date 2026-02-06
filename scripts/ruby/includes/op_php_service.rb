# frozen_string_literal: false

require_relative 'np_service'

class OpPhpService < NpService
  def prepare_service; end

  def prepare_local_service; end

  def create_convox_app; end

  def start_command; end

  def run_connect_command; end
end
