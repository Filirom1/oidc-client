require 'json'
require 'yaml'
require 'rest-client'

module Oidc
  module Client
    class Registration
      def initialize(config)
        @config  = config
      end
      def register(options, initial_access_token)
        raise 'missing clientId' unless options['clientId']
        body = JSON.parse(File.read("#{@config['project_dir']}/template/registration.json"))
        body  = body.merge options
        begin
          resp = RestClient.post(@config["registration_endpoint"].gsub('openid-connect', 'default'), body.to_json, {content_type: :json, accept: :json, authorization: "Bearer #{initial_access_token}"})
        rescue => e
          puts e.response.body
          raise e
        end
      end
    end
  end
end
