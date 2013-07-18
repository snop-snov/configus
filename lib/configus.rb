require "configus/version"

module Configus
  require 'configus/builder'
  require 'configus/config'

  def self.build(env_name, &block)
    b = Builder.new
    b.instance_eval(&block)
    raise "Env does not exist" unless b.has_env? env_name
  end
end
