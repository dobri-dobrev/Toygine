require 'test/unit'
require_relative '../../../lib/Toygine.rb'
require_relative '../mocks/MockFile.rb'

class UnitTestsCSSParser <Test::Unit::TestCase
  def test_initializer
    mock_file = MockFile.new(["Hello"])
  	fr = FileReader.new(mock_file, "test_path")
  	cp = CSSParser.new(fr)
  end

  def test_parse_color
    mock_file = MockFile.new(["#332211"])
  	fr = FileReader.new(mock_file, "test_path")
  	cp = CSSParser.new(fr)
  	cv = cp.parse_color()
  	assert_equal(cv.r, "33")
  	assert_equal(cv.g, "22")
  	assert_equal(cv.b, "11")
  	assert_equal(cv.type, CSSValueType::COLORVALUE)
  end

  def test_parse_length
    mock_file = MockFile.new(["33px"])
  	fr = FileReader.new(mock_file, "test_path")
  	cp = CSSParser.new(fr)
  	cv = cp.parse_length()
  	assert_equal(cv.length, 33)
  	assert_equal(cv.unit, CSSLengthUnitType::UNIT_TYPES[0])
  	assert_equal(cv.type, CSSValueType::LENGTH)
  end

  def test_parse_key_word
    mock_file = MockFile.new(["left"])
  	fr = FileReader.new(mock_file, "test_path")
  	cp = CSSParser.new(fr)
  	cv = cp.parse_key_word()
  	assert_equal(cv.keyword, "left")
  	assert_equal(cv.type, CSSValueType::KEYWORD)
  end

  def test_parse_declaration
    mock_file = MockFile.new(["background-color: #332211;"])
  	fr = FileReader.new(mock_file, "test_path")
  	cp = CSSParser.new(fr)
  	declaration = cp.parse_declaration()
  	assert_equal(declaration.name, "background-color")
  	assert_equal(declaration.value.type, CSSValueType::COLORVALUE)
  end

  def test_parse_declaration_2
    mock_file = MockFile.new(["margin-left: 20pt;"])
  	fr = FileReader.new(mock_file, "test_path")
  	cp = CSSParser.new(fr)
  	declaration = cp.parse_declaration()
  	assert_equal(declaration.name, "margin-left")
  	assert_equal(declaration.value.type, CSSValueType::LENGTH)
  end


end
