require 'test/unit'
require_relative '../../../lib/Toygine.rb'

class UnitTestsHTMLNode <Test::Unit::TestCase
  def test_initialize
  	node = Node.new(HTMLNodeType::TEXT, {}, [], "blah")
  	assert_equal(HTMLNodeType::TEXT, node.type)
    assert_equal("blah", node.text)
    node = Node.new(HTMLNodeType::A, "blah")
  end
  


end

