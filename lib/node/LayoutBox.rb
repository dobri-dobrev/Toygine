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

  def layout(containing_block)
    case @box_type
    when BoxType::BLOCK_NODE
      return self.layout_block(containing_block)
    when BoxType::INLINE_NODE
      raise "Unsupported layout type" #TODO: implement this
    when BoxType::ANONYMOUS_BLOCK
      raise "Unsupported layout type"  #TODO: implement this
    end
  end

  def layout_block(containing_block)
    #TODO implement
    puts "test"
    "t"
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

  def calculate_block_width(containing_block)
    zero = CSSValue.new(CSSValueType::LENGTH, {:length => 0, :unit => "px"})
    width = @style_node.value("width")|| CSSValue.new(CSSValueType::LENGTH, {:length => 0, :unit => "px"})

    margin_left = @style_node.lookup("margin-left", "margin", zero)
    margin_right = @style_node.lookup("margin-right", "margin", zero)

    border_left = @style_node.lookup("border-left-width", "border-width", zero)
    border_right = @style_node.lookup("border-right-width", "border-width", zero)

    padding_left = @style_node.lookup("padding-left", "padding", zero)
    padding_right = @style_node.lookup("padding-right", "padding", zero)
    
    total = 0
    [margin_left, margin_right, border_left, border_right, padding_left, padding_right, width].each { |e| total += e.to_px()}

    if !(width.type.eql? CSSValueType::KEYWORD and width.keyword.eql? "auto") and total > containing_block.content.width
      if margin_left.type.eql? CSSValueType::KEYWORD and margin_left.keyword.eql? "auto"
        margin_left = CSSValue.new(CSSValueType::LENGTH, {:length => 0, :unit => "px"})
      end
      if margin_right.type.eql? CSSValueType::KEYWORD and margin_right.keyword.eql? "auto"
        margin_right = CSSValue.new(CSSValueType::LENGTH, {:length => 0, :unit => "px"})
      end
    end

    underflow = containing_block.content.width - total

    mla = (margin_left.type.eql? CSSValueType::KEYWORD and margin_left.keyword.eql? "auto")
    mra = (margin_right.type.eql? CSSValueType::KEYWORD and margin_right.keyword.eql? "auto")
    wa = (width.type.eql? CSSValueType::KEYWORD and width.keyword.eql? "auto")

    if !wa and !mla and !mra
      margin_right = CSSValue.new(CSSValueType::LENGTH, {:length => margin_right.to_px() + underflow, :unit => "px"})
    end

    if !wa and !mla and mra
      margin_right = CSSValue.new(CSSValueType::LENGTH, {:length => underflow, :unit => "px"})
    end

    if !wa and mla and !mra
      margin_left = CSSValue.new(CSSValueType::LENGTH, {:length => underflow, :unit => "px"})
    end

    if wa
      if mla
        margin_left = CSSValue.new(CSSValueType::LENGTH, {:length => 0, :unit => "px"})
      end
      if mra
        margin_right = CSSValue.new(CSSValueType::LENGTH, {:length => 0, :unit => "px"})
      end
      if underflow >= 0
        width = CSSValue.new(CSSValueType::LENGTH, {:length => underflow, :unit => "px"})
      else
        width = CSSValue.new(CSSValueType::LENGTH, {:length => 0, :unit => "px"})
        margin_right = CSSValue.new(CSSValueType::LENGTH, {:length => margin_right.to_px() + underflow, :unit => "px"})
      end
    end

    if !wa and mla and mra
      margin_right = CSSValue.new(CSSValueType::LENGTH, {:length => underflow/2, :unit => "px"})
      margin_left = CSSValue.new(CSSValueType::LENGTH, {:length => underflow/2, :unit => "px"})
    end

    if @dimensions.nil? 
      @dimensions = Dimensions.new(Rect.new(0,0,0,0), EdgeSizes.new(0,0,0,0), EdgeSizes.new(0,0,0,0), EdgeSizes.new(0,0,0,0))
    end
    @dimensions.content.width = width.to_px()

    @dimensions.padding.left = padding_left.to_px()
    @dimensions.padding.right = padding_right.to_px()

    @dimensions.border.left = border_left.to_px()
    @dimensions.border.right = border_right.to_px()

    @dimensions.margin.left = margin_left.to_px()
    @dimensions.margin.right = margin_right.to_px()
  end

  def calculate_position(containing_block)
    zero = CSSValue.new(CSSValueType::LENGTH, {:length => 0, :unit => "px"})
    @dimensions.margin.top = @style_node.lookup("margin-top", "margin", zero)
    @dimensions.margin.bottom = @style_node.lookup("margin-bottom", "margin", zero)

    @dimensions.border.top = @style_node.lookup("border-top-width", "border-width", zero)
    @dimensions.border.bottom = @style_node.lookup("border-bottom-width", "border-width", zero)

    @dimensions.padding.top = @style_node.lookup("padding-top", "padding", zero)
    @dimensions.padding.bottom = @style_node.lookup("padding-bottom", "padding", zero)

    @dimensions.content.x = @dimensions.margin.left + @dimensions.padding.left + @dimensions.border.left + containing_block.content.x
    @dimensions.content.y = @dimensions.margin.top + @dimensions.padding.top + @dimensions.border.top + containing_block.content.height + containing_block.content.y

  end

  def layout_block_children(containing_block)
    @children.each { |child| 
      child.layout(@dimensions)  
      @dimensions.content.height += child.dimensions.margin_box().height
    }
  end

  def calculate_block_height
    if @style_node.value("height")
      @dimensions.content.height = @style_node.value("height")
    end
  end

  
end

module BoxType
  BLOCK_NODE = "block_node"
  INLINE_NODE = "inline_node"
  ANONYMOUS_BLOCK = "anonymous_block" 
end