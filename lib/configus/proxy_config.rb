module Configus

  class ProxyConfig < Object
    attr_reader :conf

    def initialize
      @conf = Config.new
    end

    def method_missing(method_name, *args, &block)
      #if block_given?
      #  conf[method_name] = Config.new
      #  conf[method_name].instance_eval(&block)
      #else
      #  conf[method_name] = args.first
      #end
      #create_method(method_name, *args, &block)
      if @conf.respond_to? method_name
        @conf.method(method_name).call(*args)
      else
        @conf.add_property(method_name, *args, &block)
      end
    end

  end
end