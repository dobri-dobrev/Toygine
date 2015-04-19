class StyleNode
  attr_accessor :html_node, :specified_values, :children

  def initialize(node)
    @html_node = node
  end
  
  
end

module Display
  INLINE = "inline"
  BLOCK = "block"
  NONE = "none"
end