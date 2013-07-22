#require 'active_support/core_ext/hash/deep_merge.rb'

module Configus
  class HashCreator

    attr_reader :properties

    def initialize(&block)
      @properties = {}
      instance_eval(&block)
    end

    def self.generate_hash(&block)
      gen = new(&block)
      gen.properties
    end

    def method_missing(method_name, *args, &block)
      if block_given?
        @properties[method_name] = HashCreator.generate_hash(&block)
      else
        @properties[method_name] = args.first
      end
    end

  end
end