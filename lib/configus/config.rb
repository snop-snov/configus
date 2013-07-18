module Configus
  class Config < Hash

    def method_missing(method_name, *args, &block)
      if block_given?
        self[method_name] = Config.new
        self[method_name].instance_eval(&block)
      end

      if self.has_key?(method_name)
        self[method_name]
      else
        self[method_name] = args.first
      end
    end
  end
end