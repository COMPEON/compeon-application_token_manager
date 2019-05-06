# frozen_string_literal: true

require 'compeon/application_token_manager/version'

require 'aws-sdk-ssm'

module Compeon
  class ApplicationTokenManager
    EXPIRY_THRESHOLD_IN_SECONDS = 30

    def initialize(environment: nil, client_id: nil)
      @client = Aws::SSM::Client.new
      @client_id = client_id || ENV.fetch('COMPEON_CLIENT_ID')
      @expires_at = 0
      @environment = environment || ENV.fetch('ENVIRONMENT')
    end

    def token
      @token = nil if expired?
      @token ||= fetch_token
    end

    private

    attr_reader :client, :client_id, :expires_at, :environment

    def expired?
      Time.now.to_i > (expires_at - EXPIRY_THRESHOLD_IN_SECONDS)
    end

    def fetch_token
      parameter_path = "/#{environment}/#{client_id}/private/token"

      parameters = client.get_parameters_by_path(
        path: parameter_path,
        recursive: true,
        with_decryption: true
      ).parameters

      @expires_at = parameters.find { |parameter| parameter.name == "#{parameter_path}/expires_at" }.value.to_i
      parameters.find { |parameter| parameter.name == "#{parameter_path}/string" }.value
    end
  end
end
