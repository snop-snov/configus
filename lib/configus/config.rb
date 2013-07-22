#require 'active_support/core_ext/hash/deep_merge.rb'

module Configus
  class Config
    def initialize(conf_hash)
      @properties = conf_hash
      create_methods(@properties)
    end

    def to_hash
      @properties.clone
    end

    private
    def create_method(method_name, value)
      define_singleton_method(method_name) do
        value
      end
    end

    def create_methods(properties)
      properties.each do  |key, value|
        if value.is_a? Hash
          create_method(key, self.class.new(value))
        else
          create_method(key, value)
        end
      end
    end

    def method_missing(method_name, *args, &block)
      raise ConfigPropertyAccessError.new "Configs property #{method_name} does not exist"
    end
  end
end