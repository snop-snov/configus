require "configus/version"
require 'configus/kernel_extension'

module Configus
  autoload 'Builder', 'configus/builder'
  autoload 'Config', 'configus/config'
  autoload 'HashCreator', 'configus/hash_creator'

  #autoload 'ProxyConfig', 'configus/proxy_config'

  def self.build(env_name, &block)
    @conf = Builder.build(env_name, &block)
  end

  def self.configuration
    @conf
  end
end