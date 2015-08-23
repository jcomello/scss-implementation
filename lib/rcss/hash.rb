class Hash
  def unnest
    new_hash = {}
    each do |key,val|
      new_hash[key] = ""

      val.each do |el|
        if el.is_a?(Hash)
          new_hash.merge!(el.prefix_keys("#{key} "))
        else
          new_hash[key] << el + " "
        end
      end
    end
    new_hash
  end

  def prefix_keys(prefix)
    Hash[map{|key,val| [prefix + key, val]}].unnest
  end
end
