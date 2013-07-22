require "configus/version"
require 'configus/core_ext/kernel'

module Configus
  autoload 'Builder', 'configus/builder'
  autoload 'Config', 'configus/config'
  autoload 'ConfigHashCreator', 'configus/config_hash_creator'

  class EnvironmentError < RuntimeError; end
  class EnvironmentLoopError < EnvironmentError; end
  class EnvironmentEmptyError < EnvironmentError; end

  class AccessError < RuntimeError; end
  class ConfigPropertyAccessError < AccessError; end
  class EnvironmentAccessError < AccessError; end

  def self.build(current_env_name, &block)
    @conf = Builder.build(current_env_name, &block)
  end

  def self.configuration
    @conf
  end
end