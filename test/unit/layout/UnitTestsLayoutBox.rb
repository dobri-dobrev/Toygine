require 'test/unit'
require_relative '../../../lib/Toygine.rb'

class UnitTestsLayoutBox <Test::Unit::TestCase
  def test_initialize
    t = LayoutBox.new(1, 2, 3)
    assert_equal(1, t.dimensions)
    assert_equal(2, t.box_type)
    assert_equal(3, t.children)
  end
end

