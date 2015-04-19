class StyleNode
  attr_accessor :html_node, :specified_values, :children

  def initialize(node, vals)
    @html_node = node
    @specified_values = vals
    @children = []
  end

  def add_child(child)
    @children << child
  end

  def display
    if @specified_values["display"].nil?
      return Display::INLINE
    else
      return @specified_values["display"].keyword
    end
  end
  #return CSSValue
  def value(key)
    return @specified_values[key]
  end

  #TODO implement to_s
  def to_s
   return @html_node.to_s()
  end
  #TODO implement to_s
  def print
    puts @html_node
  end
end

module Display
  INLINE = "inline"
  BLOCK = "block"
  NONE = "none"
end