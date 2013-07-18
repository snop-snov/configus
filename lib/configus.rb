require "configus/version"

module Configus

  class Builder
    def self.env(name, &block)
      conf = Config.new
      conf.instance_eval(&block)
      conf
      #raise "XXXXXXXXXXX" << conf.inspect
    end
  end

  class Config < Hash
    #def get_method_name(name_str)
    #  name_str[0, name_str.length - 1].to_sym
    #end


    def method_missing(method_name, *args, &block)
      #method_name = get_method_name(method_name) if method_name =~ /\=$/
      #tt = block_given?
#raise "XXXXXXXXXXXXX" << tt.inspect

      if block_given?
        self[method_name] = Config.new
      end

      if self.has_key?(method_name)
        self[method_name]
      else
        self[method_name] = args.first
      end
    end

  end
end
