require "configus/version"

module Configus
  autoload 'Builder', 'configus/builder'
  autoload 'Config', 'configus/config'

  def self.build(env_name, &block)
    Builder.build(env_name, &block)
  end
end