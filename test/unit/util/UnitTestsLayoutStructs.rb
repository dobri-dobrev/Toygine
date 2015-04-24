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
    rect = EdgeSizes.new(2, 3, 4, 5)
    assert_equal(2, rect.left)
    assert_equal(3, rect.right)
    assert_equal(4, rect.top)
    assert_equal(5, rect.bottom)
  end

  def test_dimensions
    rect = Dimensions.new(Rect.new(1,2,3,4) , 3, 4, 5)
    assert_equal(1, rect.content.x)
    assert_equal(3, rect.padding)
    assert_equal(4, rect.border)
    assert_equal(5, rect.margin)
  end
end

