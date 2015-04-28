class LayoutBox < BaseNode
  attr_accessor :dimensions, :box_type, :style_node, :children

  def initialize(dim, type, s_n, chil)
    @dimensions = dim
    @box_type = type
    @style_node = s_n
    @children = chil
  end
end

module BoxType
  BLOCK_NODE = "block_node"
  INLINE_Node = "inline_node"
  ANONYMOUS_BLOCK = "anonymous_block" 
end