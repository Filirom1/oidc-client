require 'json'
require 'yaml'
require 'rest-client'

module Oidc
  module Client
    class Config
      def self.load()
        project_dir = "#{File.dirname(__FILE__)}/../../../"
        config = YAML.load_file("#{project_dir}/config/client.yml")
        resp = RestClient.get(config["oidc_discovery_url"])
        config = JSON.parse(resp.body).merge(config)
        config['project_dir'] = project_dir

	config
      end
    end
  end
end
