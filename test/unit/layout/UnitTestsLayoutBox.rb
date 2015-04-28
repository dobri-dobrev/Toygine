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
end

