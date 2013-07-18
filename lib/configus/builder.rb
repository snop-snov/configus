module Configus
  class Builder
    def initialize
      @settings = {}
    end

    def env(name, &block)
      conf = Config.new
      conf.instance_eval(&block)
      @settings[name] = conf
      conf
    end

    def has_env?(env_name)
      @settings.has_key? env_name
    end
  end
end