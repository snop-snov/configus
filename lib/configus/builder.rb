require 'active_support/core_ext/hash/deep_merge.rb'
#require 'configus/proxy_config'

module Configus
  #autoload 'Merging', 'configus/merging'
  #autoload 'DeepMerge', 'active_support/core_ext/hash/deep_merge.rb'

  class Builder
    def initialize
      @settings = {}
    end

    def self.build(current_env_name, &block)
      builder = new
      builder.instance_eval(&block)

      if builder.has_env? current_env_name
        builder.env_config(current_env_name)
      else
        raise EnvironmentAccessError.new "Environment does not exist"
      end
    end

    def has_env?(current_env_name)
      @settings.has_key? current_env_name
    end

    def env_config(current_env_name)
      inherited_parents = []
      conf_hash = build_config_hash(current_env_name, inherited_parents)
      raise EnvironmentEmptyError.new "Environment is empty" if conf_hash.empty?
      conf = Config.new(conf_hash)
    end

    private
    def env(name, options = {}, &block)
      @settings[name] = {:options => options, :block => block}
    end

    def build_parent_env_hash(env_name, inherited_parents)
      parent_env_name = @settings[env_name][:options][:parent]
      raise EnvironmentLoopError.new "You have loop inheriting for #{parent_env_name}" if inherited_parents.include?(parent_env_name)

      conf_parent_hash = build_config_hash(parent_env_name, inherited_parents)
    end

    def build_config_hash(env_name, inherited_parents)
      conf_hash = {}
      inherited_parents << env_name

      block = @settings[env_name][:block]
      conf_hash = ConfigHashCreator.generate_hash(&block) if block

      if (@settings[env_name][:options][:parent])
        conf_parent_hash = build_parent_env_hash(env_name, inherited_parents)
        conf_hash = conf_parent_hash.deep_merge(conf_hash)
      end
      conf_hash
    end
  end
end