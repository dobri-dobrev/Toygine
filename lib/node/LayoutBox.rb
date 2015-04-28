class LayoutBox < BaseNode
  attr_accessor :dimensions, :box_type, :children

  def initialize(dim, type, chil)
    @dimensions = dim
    @box_type = type
    @children = chil
  end
end

module BoxType
  BLOCK_NODE = "block_node"
  INLINE_Node = "inline_node"
  ANONYMOUS_BLOCK = "anonymous_block" 
end