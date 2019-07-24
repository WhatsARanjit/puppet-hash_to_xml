Puppet::Functions.create_function(:hash_to_xml) do
  dispatch :hash_to_xml do
    param 'Hash', :data
    optional_param 'Integer', :level
    optional_param 'String', :character
    optional_param 'Integer', :num
  end

  def calc_indent(level)
    @character * @num * level
  end

  def kv_to_xml(k, v = nil, level = 0, open = true, close = true)
    output = ''
    output += calc_indent(level)
    output +="<#{k}>" if open
    output += v if (open and close)
    output += "</#{k}>" if close
    output += "\n"
  end

  def hash_to_xml(h, level = 0, character = "\s", num = 2)
    @character             = character
    @num                   = num
    xml                    = ''
    h.each do |key, value|
      case value
      when String
        xml += kv_to_xml(key, value, level)
      when Hash
        xml += kv_to_xml(key, nil, level, true, false)
        xml += hash_to_xml(value, level+1, @character, @num)
        xml += kv_to_xml(key, nil, level, false, true)
      when FalseClass
        xml += kv_to_xml(key, nil, level, true, false)
      else
        fail('Error')
      end
    end
    return xml
  end
end
