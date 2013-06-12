module PpwmMatcher
  module GithubAuth

    module_function

    def options
      {
      :scopes    => "user:email",
      :secret    => secret,
      :client_id => client_id,
    }
    end


    def secret
      dev_config[secret_key] || ENV[secret_key]
    end
    def secret_key
     'GITHUB_CLIENT_SECRET'
     end
    def client_id
      dev_config[client_id_key] || ENV[client_id_key]
    end
    def client_id_key
     'GITHUB_CLIENT_ID'
    end
    def dev_config
      config.fetch('development', {})
    end
    def prod_config
      config.fetch('production', {})
    end
    def config
      @config ||= if File.exists?(app_config_filename)
                    YAML.load(File.read(app_config_filename))
                  else
                    {}
                  end
    end
    def app_config_filename
      'config/application.yml'
    end
  end
end
