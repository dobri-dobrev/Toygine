require 'test/unit'
require_relative '../lib/Toygine.rb'

class UnitTestsCSSValue <Test::Unit::TestCase
  def test_color
  	cv = CSSValue.new(CSSValueType::COLORVALUE, {:r => 255, :g => 244, :b => 233})
    assert_equal(cv.type, CSSValueType::COLORVALUE)
    assert_equal(cv.r, 255)
    assert_equal(cv.g, 244)
    assert_equal(cv.b, 233)
  end
  def test_length
  	cv = CSSValue.new(CSSValueType::LENGTH, {:length => 10, :unit => "px"})
  	assert_equal(cv.type, CSSValueType::LENGTH)
    assert_equal(cv.length, 10)
    assert_equal(cv.unit, CSSLengthUnitType::UNIT_TYPES[0])
  end
  def test_keyword
    cv = CSSValue.new(CSSValueType::KEYWORD, {:word => "left"})
    assert_equal(cv.type, CSSValueType::KEYWORD)
    assert_equal(cv.keyword, "left")
  end
end
