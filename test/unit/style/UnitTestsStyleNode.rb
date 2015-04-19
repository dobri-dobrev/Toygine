require 'test/unit'
require_relative '../../../lib/Toygine.rb'
require_relative '../mocks/MockFile.rb'

class UnitTestsStyleNode <Test::Unit::TestCase
  def test_initialize
    html_node = Node.new(HTMLNodeType::IMG, {}, [], nil)
    style_node = StyleNode.new(html_node)
    assert_equal(html_node, style_node.html_node)
  end
    

end

