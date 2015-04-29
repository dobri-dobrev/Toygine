class LayoutBox < BaseNode
  attr_accessor :dimensions, :box_type, :style_node, :children

  def initialize(dim, type, s_n, chil)
    @dimensions = dim
    @box_type = type
    if s_n.nil?
    	@style_node = s_n	
    else
    	@style_node = s_n.clone()
    	@style_node.reset_children()
    end
    super(chil)
  end

  def get_inline_container
  	case @box_type
  	when BoxType::BLOCK_NODE
  		if self.children().length > 0 and self.children().last().box_type.eql? BoxType::ANONYMOUS_BLOCK
  			return self.children().last()
  		else
  			self.add_child(LayoutBox.new(nil, BoxType::ANONYMOUS_BLOCK, nil, nil))
  			return self.children().last()
  		end
  	when BoxType::INLINE_NODE
  		return self
  	when BoxType::ANONYMOUS_BLOCK
  		return self
  	end
  end
end

module BoxType
  BLOCK_NODE = "block_node"
  INLINE_NODE = "inline_node"
  ANONYMOUS_BLOCK = "anonymous_block" 
end