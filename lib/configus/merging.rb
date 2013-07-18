module Merging
=begin
    def deep_merge(other_hash)
      self.merge(other_hash) do |key, oldval, newval|
        oldval = oldval.to_hash if oldval.respond_to?(:to_hash)
        newval = newval.to_hash if newval.respond_to?(:to_hash)
        if oldval.class.to_s == 'Hash' && newval.class.to_s == 'Hash'
          Config[oldval].deep_merge(Config[newval])
        else
          newval
        end
      end
    end
=end

  def deep_merge(src_hash, other_hash)
    src_hash.merge(other_hash) do |key, oldval, newval|
      #if oldval.class.to_s == 'Hash' && newval.class.to_s == 'Hash'
      if oldval.is_a?(Hash) && newval.is_a?(Hash)
        deep_merge(oldval, newval)
      else
        newval
      end
    end
  end

end