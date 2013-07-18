module Configus
  autoload 'Merging', 'configus/merging'

  class Builder
    include Merging

    def initialize
      @settings = {}
    end

    def self.build(env_name, &block)
      build = Builder.new
      build.instance_eval(&block)

      if build.has_env? env_name
        build.env_config(env_name)
      else
        raise "Env does not exist"
      end
    end

    def env(name, options = {}, &block)
      conf = Config.new
      conf.instance_eval(&block)
      if options[:parent]
        conf = deep_merge(@settings[options[:parent]], conf)
      end
      @settings[name] = conf
      conf
    end

    def has_env?(env_name)
      @settings.has_key? env_name
    end

    def env_config(env_name)
      @settings[env_name]
    end

  end
end