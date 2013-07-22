require 'active_support/core_ext/hash/deep_merge.rb'
#require 'configus/proxy_config'

module Configus
  #autoload 'Merging', 'configus/merging'
  #autoload 'DeepMerge', 'active_support/core_ext/hash/deep_merge.rb'

  class Builder
    def initialize
      @settings = {}
      @inherited_parents = []
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

    def has_env?(env_name)
      @settings.has_key? env_name
    end

    def env_config(env_name)
      @inherited_parents.clear
      conf_hash = inherited_conf(env_name)
      raise "Environment is empty" if conf_hash.empty?
      conf = Config.new(conf_hash)
    end

    private
    def env(name, options = {}, &block)
      @settings[name] = {:options => options, :block => block}
    end

    def parent_hash(env_name)
      parent_env_name = @settings[env_name][:options][:parent]
      raise "You have loop inheriting for #{parent_env_name}" if @inherited_parents.include?(parent_env_name)
      conf_parent_hash = inherited_conf(parent_env_name)
    end

    def inherited_conf(env_name)
      conf_hash = {}
      @inherited_parents << env_name
      block = @settings[env_name][:block]
      conf_hash = HashCreator.generate_hash(&block) if block

      if (@settings[env_name][:options][:parent])
        conf_parent_hash = parent_hash(env_name)
        conf_hash = conf_parent_hash.deep_merge(conf_hash)
      end
      conf_hash
    end
  end
end