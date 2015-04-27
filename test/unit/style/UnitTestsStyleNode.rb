require 'test/unit'
require_relative '../../../lib/Toygine.rb'


class UnitTestsStyleNode <Test::Unit::TestCase
  def test_initialize
    html_node = Node.new(HTMLNodeType::IMG, {}, [], nil)
    style_node = StyleNode.new(html_node, {})
    assert_equal(html_node.type, style_node.html_node.type)
    assert_equal(html_node.children, style_node.html_node.children)
    assert_equal({}, style_node.specified_values)
    assert_equal([], style_node.children)
  end
  
  def test_add_child
  	html_node = Node.new(HTMLNodeType::IMG, {}, [], nil)
    style_node = StyleNode.new(html_node, {})
    style_node.add_child(StyleNode.new(html_node, {}))
    assert_equal(1, style_node.children.length)
  end

  def test_display
  	html_node = Node.new(HTMLNodeType::IMG, {}, [], nil)
  	style_node = StyleNode.new(html_node, {"display" => CSSValue.new(CSSValueType::KEYWORD, {:word => Display::NONE})})
  	assert_equal(Display::NONE, style_node.display())

  	style_node = StyleNode.new(html_node, {})
	  assert_equal(Display::INLINE, style_node.display())  	
  end

  def test_value
    html_node = Node.new(HTMLNodeType::IMG, {}, [], nil)
    style_node = StyleNode.new(html_node, {"width" => CSSValue.new(CSSValueType::LENGTH, {:length => 10, :unit => "pt"})})
    assert_equal(10, style_node.value("width").length)
    assert_equal(nil, style_node.value("height"))
  end

end

