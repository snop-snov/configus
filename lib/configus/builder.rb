#require 'active_support/core_ext/hash/deep_merge.rb'

module Configus
  #autoload 'Merging', 'configus/merging'
  #autoload 'DeepMerge', 'active_support/core_ext/hash/deep_merge.rb'

  class Builder
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
        parent_env_name = options[:parent]
        #conf = @settings[parent_env_name].deep_merge(conf)
        #conf.create_methods
        conf = @settings[parent_env_name].deep_merging(conf)
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