require 'test/unit'
require_relative '../../../lib/Toygine.rb'

class UnitTestsHTMLNode <Test::Unit::TestCase
  def test_initialize
    node = Node.new(HTMLNodeType::TEXT, {}, [], "blah")
    assert_equal(HTMLNodeType::TEXT, node.type)
    assert_equal("blah", node.text)
    node = Node.new(HTMLNodeType::A, {"float" => "left"}) 
    assert_equal(HTMLNodeType::A, node.type)
    assert_equal("left", node.attributes["float"])
  end
  
  def test_add_child
    node = Node.new(HTMLNodeType::TEXT, {}, [], "blah")
    node.add_child(Node.new(HTMLNodeType::A, {}, [], "blah2"))
    assert_equal(1, node.children.length)
    assert_equal(HTMLNodeType::A, node.children[0].type)
  end

  def test_id
    node = Node.new(HTMLNodeType::TEXT, {"id" => "the_id"}, [], "blah")
    assert_equal("the_id", node.id)
    node = Node.new(HTMLNodeType::TEXT, {}, [], "blah")
    assert_equal(nil, node.id)
  end

  def test_classes
    node = Node.new(HTMLNodeType::TEXT, {"class" => "blah bling"}, [], "blah")
    assert_equal({"blah" => true, "bling" => true}, node.classes)
    node = Node.new(HTMLNodeType::TEXT, {}, [], "blah")
    assert_equal({}, node.classes)
  end

  def test_to_s
    node = Node.new(HTMLNodeType::TEXT, {}, [], "blah")
    print_string = "NODE:\n"
    print_string += "type: text\n"
    print_string += "attributes: {}\n"
    print_string += "text: blah\n"
    assert_equal(print_string, node.to_s)
  end
end

