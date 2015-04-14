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

  def test_parse_declaration_3
    mock_file = MockFile.new(["float: left;"])
  	fr = FileReader.new(mock_file, "test_path")
  	cp = CSSParser.new(fr)
  	declaration = cp.parse_declaration()
  	assert_equal(declaration.name, "float")
  	assert_equal(declaration.value.type, CSSValueType::KEYWORD)
  end

  def test_parse_selector
  	mock_file = MockFile.new(["#id2.a"])
  	fr = FileReader.new(mock_file, "test_path")
  	cp = CSSParser.new(fr)
  	selector = cp.parse_selector()
  	assert_equal(selector.ids[0], "id2")
  	assert_equal(selector.classes[0], "a")
  end

  def test_parse_rule
  	mock_arr = ["a{"]
  	mock_arr << "margin-left: 10px;"
  	mock_arr << "}"
  	mock_file = MockFile.new(mock_arr)
  	fr = FileReader.new(mock_file, "test_path")
  	cp = CSSParser.new(fr)
  	rule = cp.parse_rule()
  	assert_equal(rule.declarations.length, 1)
  	assert_equal(rule.selectors.length, 1)
  	assert_equal(fr.current_char(), "}")
  end

  def test_parse_rule_twice_in_a_row
  	mock_arr = ["a{"]
  	mock_arr << "margin-right: 10px;"
  	mock_arr << "}"
  	mock_arr << "div{"
  	mock_arr << "margin-left: 10px;"
  	mock_arr << "}"
  	mock_file = MockFile.new(mock_arr)
  	fr = FileReader.new(mock_file, "test_path")
  	cp = CSSParser.new(fr)
  	rule = cp.parse_rule()
  	assert_equal(rule.declarations[0].name, "margin-right")
  	rule = cp.parse_rule()
  	assert_equal(rule.selectors[0].tag_names[0], "div")
  	assert_equal(rule.selectors[0].tag_names.length, 1)
  	assert_equal(rule.selectors[0].classes.length, 0)
  	assert_equal(rule.selectors[0].ids.length, 0)
  end

  def test_parse
  	mock_arr = ["a{"]
  	mock_arr << "margin-right: 10px;"
  	mock_arr << "}"
  	mock_arr << "div{"
  	mock_arr << "margin-left: 10px;"
  	mock_arr << "}"
  	mock_file = MockFile.new(mock_arr)
  	fr = FileReader.new(mock_file, "test_path")
  	cp = CSSParser.new(fr)
  	rules = cp.parse()
  	assert_equal(rules[0].declarations[0].name, "margin-right")
  	assert_equal(rules[1].selectors[0].tag_names[0], "div")
  	assert_equal(rules[1].selectors[0].tag_names.length, 1)
  	assert_equal(rules[1].selectors[0].classes.length, 0)
  	assert_equal(rules[1].selectors[0].ids.length, 0)
  	assert_equal(rules[1].declarations[0].value.type, CSSValueType::LENGTH)
  	assert_equal(rules[1].declarations[0].value.unit, "px")
  end
end
