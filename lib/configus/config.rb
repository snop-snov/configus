require 'active_support/core_ext/hash/deep_merge.rb'

module Configus
  class Config < Hash
    #private
    def create_method(method_name, *args, &block)
      define_singleton_method(method_name) do
        self[method_name]
      end
    end

    def create_methods
      self.each do |key, value|
        value.create_methods if value.is_a? Hash
        self.create_method(key, value)
      end
    end

    #public
    def deep_merging(other_conf)
      self.deep_merge!(other_conf)
      self.create_methods
    end

    def method_missing(method_name, *args, &block)
      if block_given?
        self[method_name] = Config.new
        self[method_name].instance_eval(&block)
      else
        self[method_name] = args.first
      end
      create_method(method_name, *args, &block)
    end

  end
end