require 'test/unit'
require_relative '../../../lib/Toygine.rb'

class UnitTestsLayoutTransformer <Test::Unit::TestCase
  def test_build_layout_tree
    sn = StyleNode.new(Node.new(HTMLNodeType::HTML, {}, [], "blah"), {})
    t = LayoutTransformer.build_layout_tree(sn)
    assert_equal(0, t.children().length)
    assert_equal(BoxType::INLINE_NODE, t.box_type)

    sn = StyleNode.new(Node.new(HTMLNodeType::HTML, {}, [], "blah"), {"display" => CSSValue.new(CSSValueType::KEYWORD, {:word => Display::BLOCK})})
    sn.add_child(StyleNode.new(Node.new(HTMLNodeType::BODY, {}, []), {}))
    t = LayoutTransformer.build_layout_tree(sn)
    assert_equal(1, t.children().length)
    assert_equal(1, t.children()[0].children().length)
    assert_equal(BoxType::ANONYMOUS_BLOCK, t.children()[0].box_type)
    assert_equal(BoxType::INLINE_NODE, t.children()[0].children()[0].box_type)
  end
end

