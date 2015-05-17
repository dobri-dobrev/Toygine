require 'test/unit'
require_relative '../../../lib/Toygine.rb'


class UnitTestsLayoutStructs <Test::Unit::TestCase
  def test_rect
    rect = Rect.new(2, 3, 4, 5)
    assert_equal(2, rect.x)
    assert_equal(3, rect.y)
    assert_equal(4, rect.width)
    assert_equal(5, rect.height)
  end

  def test_edge_sizes
    edge = EdgeSizes.new(2, 3, 4, 5)
    assert_equal(2, edge.left)
    assert_equal(3, edge.right)
    assert_equal(4, edge.top)
    assert_equal(5, edge.bottom)
  end

  def test_dimensions
    dimensions = Dimensions.new(Rect.new(1,2,3,4) , 3, 4, 5)
    assert_equal(1, dimensions.content.x)
    assert_equal(3, dimensions.padding)
    assert_equal(4, dimensions.border)
    assert_equal(5, dimensions.margin)
  end

  def test_expanded_by
    rect = Rect.new(3, 4, 4, 5)
    edge = EdgeSizes.new(2, 3, 3, 5)
    rect.expanded_by(edge)
    assert_equal(1, rect.x)
    assert_equal(1, rect.y)
    assert_equal(9, rect.width)
    assert_equal(13, rect.height)
  end
end

