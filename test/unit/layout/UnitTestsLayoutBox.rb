require 'test/unit'
require_relative '../../../lib/Toygine.rb'

class UnitTestsLayoutBox <Test::Unit::TestCase
  def test_initialize
    sn = StyleNode.new(Node.new(HTMLNodeType::HTML, {}, [], "blah"), {})
    t = LayoutBox.new(1, 2, sn, 4)
    assert_equal(1, t.dimensions)
    assert_equal(2, t.box_type)
    assert_equal(0, t.style_node.children.length)
    assert_equal(HTMLNodeType::HTML, t.style_node.html_node.type)
    assert_equal(4, t.children)
  end

  def test_add_child
    sn = StyleNode.new(Node.new(HTMLNodeType::HTML, {}, [], "blah"), {})
    t = LayoutBox.new(1, 2, sn, [])
    assert_equal(0, t.children.length)
    t.add_child(2)
    assert_equal(1, t.children.length)
  end

  def test_get_inline_container
    sn = StyleNode.new(Node.new(HTMLNodeType::HTML, {}, [], "blah"), {})
    t = LayoutBox.new("test", BoxType::INLINE_NODE, sn, [])
    t2 = t.get_inline_container()
    assert_equal(t.box_type, t2.box_type)
    assert_equal(t.dimensions, t2.dimensions)

    t = LayoutBox.new("test", BoxType::ANONYMOUS_BLOCK, sn, [])
    t2 = t.get_inline_container()
    assert_equal(t.box_type, t2.box_type)
    assert_equal(t.dimensions, t2.dimensions)

    t = LayoutBox.new("test", BoxType::BLOCK_NODE, sn, [])
    t.add_child(LayoutBox.new(nil, BoxType::INLINE_NODE, sn, []))
    t2 = t.get_inline_container()
    assert_equal(2, t.children.length)
    assert_equal(BoxType::ANONYMOUS_BLOCK, t2.box_type)

    t = LayoutBox.new("test", BoxType::BLOCK_NODE, sn, [])
    t.add_child(LayoutBox.new(nil, BoxType::ANONYMOUS_BLOCK, sn, []))
    t2 = t.get_inline_container()
    assert_equal(1, t.children.length)
    assert_equal(BoxType::ANONYMOUS_BLOCK, t2.box_type)
  end

  def test_layout
    #TODO implement real test after layout_block is implemented
    sn = StyleNode.new(Node.new(HTMLNodeType::HTML, {}, [], "blah"), {})
    t = LayoutBox.new(1, BoxType::BLOCK_NODE, sn, 4)
    assert_equal("t", t.layout(""))
  end

  def test_calculate_block_width
    c_b = Dimensions.new(Rect.new(0,0,30,0), EdgeSizes.new(0,0,0,0), EdgeSizes.new(0,0,0,0), EdgeSizes.new(0,0,0,0))

    sn = StyleNode.new(Node.new(HTMLNodeType::HTML, {}, [], "blah"), {})
    t = LayoutBox.new(nil, BoxType::BLOCK_NODE, sn, [])
    t.calculate_block_width(c_b)
    assert_equal(0, t.dimensions.content.width)

    sn = StyleNode.new(Node.new(HTMLNodeType::HTML, {}, [], "blah"), {"width" => CSSValue.new(CSSValueType::LENGTH, {:length => 20, :unit => "px"})})
    t = LayoutBox.new(nil, BoxType::BLOCK_NODE, sn, [])
    t.calculate_block_width(c_b)
    assert_equal(20, t.dimensions.content.width)

    sn = StyleNode.new(Node.new(HTMLNodeType::HTML, {}, [], "blah"), {"width" => CSSValue.new(CSSValueType::LENGTH, {:length => 40, :unit => "px"})})
    t = LayoutBox.new(nil, BoxType::BLOCK_NODE, sn, [])
    t.calculate_block_width(c_b)
    assert_equal(40, t.dimensions.content.width)
    assert_equal(-10, t.dimensions.margin.right)

    vals = {"margin-left" => CSSValue.new(CSSValueType::KEYWORD, {:word => "auto"})}
    vals["width"] = CSSValue.new(CSSValueType::LENGTH, {:length => 40, :unit => "px"})
    sn = StyleNode.new(Node.new(HTMLNodeType::HTML, {}, [], "blah"), vals)
    t = LayoutBox.new(nil, BoxType::BLOCK_NODE, sn, [])
    t.calculate_block_width(c_b)
    assert_equal(40, t.dimensions.content.width)
    assert_equal(-10, t.dimensions.margin.right)
    assert_equal(0, t.dimensions.margin.left)

    vals = {"margin-left" => CSSValue.new(CSSValueType::KEYWORD, {:word => "auto"})}
    vals["width"] = CSSValue.new(CSSValueType::KEYWORD, {:word => "auto"})
    vals["margin-right"] = CSSValue.new(CSSValueType::KEYWORD, {:word => "auto"})
    sn = StyleNode.new(Node.new(HTMLNodeType::HTML, {}, [], "blah"), vals)
    t = LayoutBox.new(nil, BoxType::BLOCK_NODE, sn, [])
    t.calculate_block_width(c_b)
    assert_equal(0, t.dimensions.margin.left)
    assert_equal(0, t.dimensions.margin.right)
    assert_equal(30, t.dimensions.content.width)    


    vals = {}
    vals["width"] = CSSValue.new(CSSValueType::KEYWORD, {:word => "auto"})
    vals["margin-right"] = CSSValue.new(CSSValueType::KEYWORD, {:word => "auto"})
    sn = StyleNode.new(Node.new(HTMLNodeType::HTML, {}, [], "blah"), vals)
    t = LayoutBox.new(nil, BoxType::BLOCK_NODE, sn, [])
    t.calculate_block_width(c_b)
    assert_equal(0, t.dimensions.margin.left)
    assert_equal(0, t.dimensions.margin.right)
    assert_equal(30, t.dimensions.content.width)    
  end
end

