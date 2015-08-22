module RCSS
  class Hash < Hash
    def unnest
      new_hash = {}
      each do |key,val|
        if val.is_a?(Hash)
          new_hash.merge!(val.prefix_keys("#{key}."))
        else
          new_hash[key] = val
        end
      end
      new_hash
    end

    def prefix_keys(prefix)
      Hash[map{|key,val| [prefix + key, val]}].unnest
    end
  end
end
