class StyleNode < BaseNode
  attr_accessor :html_node, :specified_values

  def initialize(node, vals)
    node_clone = node.clone()
    node_clone.reset_children()
    @html_node = node_clone
    @specified_values = vals
    super(nil)
  end
  
  def display
    return @specified_values["display"].nil? ? Display::INLINE : @specified_values["display"].keyword
  end

  #return CSSValue
  def value(key)
    return @specified_values[key]
  end

  def lookup(name, fallback_name, default)
    if @specified_values[name]
      return @specified_values[name]
    end
    if @specified_values[fallback_name]
      return @specified_values[fallback_name]
    end
    return default
  end
end

module Display
  INLINE = "inline"
  BLOCK = "block"
  NONE = "none"
end