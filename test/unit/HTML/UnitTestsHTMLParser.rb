require 'test/unit'
require_relative '../../../lib/Toygine.rb'
require_relative '../mocks/MockFile.rb'

class UnitTestsHTMLParser <Test::Unit::TestCase
  def test_initialize
    mock_file = MockFile.new(["Hello"])
    fr = FileReader.new(mock_file, "test_path")
    cp = HTMLParser.new(fr)
  end
	
	def test_is_at_beginning_of_element
	  mock_file = MockFile.new(["<Hello"])
	  fr = FileReader.new(mock_file, "test_path")
	  cp = HTMLParser.new(fr)	
	  assert_equal(true, cp.is_at_beginning_of_element())
	  mock_file = MockFile.new(["</Hello"])
	  fr = FileReader.new(mock_file, "test_path")
	  cp = HTMLParser.new(fr)	
	  assert_equal(false, cp.is_at_beginning_of_element())
	end

	def test_is_at_closing_of_element
	  mock_file = MockFile.new(["<Hello"])
	  fr = FileReader.new(mock_file, "test_path")
	  cp = HTMLParser.new(fr)	
	  assert_equal(false, cp.is_at_closing_of_element())
	  mock_file = MockFile.new(["</Hello"])
	  fr = FileReader.new(mock_file, "test_path")
	  cp = HTMLParser.new(fr)	
	  assert_equal(true, cp.is_at_closing_of_element())
	end  

	def test_consume_closing_tag
	  mock_file = MockFile.new(["<Hello  !>b"])
	  fr = FileReader.new(mock_file, "test_path")
	  cp = HTMLParser.new(fr)	
	  cp.consume_closing_tag()
	  assert_equal('b', fr.current_char())
	end

	def test_consume_attribute_value
	  mock_file = MockFile.new(["'biggie'z"])
	  fr = FileReader.new(mock_file, "test_path")
	  cp = HTMLParser.new(fr)	
	  assert_equal('biggie', cp.consume_attribute_value())
	  assert_equal('z', fr.current_char())
	end

	def test_attribute_pair
		mock_file = MockFile.new(["small = 'big'"])
	  fr = FileReader.new(mock_file, "test_path")
	  cp = HTMLParser.new(fr)
	  pair = cp.consume_attribute_pair()	
	  assert_equal('small', pair[0])
	  assert_equal('big', pair[1])
	end

	def test_consume_attribute
		mock_file = MockFile.new(["small = 'big' second='first' >"])
	  fr = FileReader.new(mock_file, "test_path")
	  cp = HTMLParser.new(fr)
	  attrs = cp.consume_attributes()
	  assert_equal('big', attrs["small"])
	  assert_equal('first', attrs["second"])
	end
	
  def test_consume_text
		mock_file = MockFile.new(["something! big, >"])
	  fr = FileReader.new(mock_file, "test_path")
	  cp = HTMLParser.new(fr)
	  text = cp.consume_text()
	  assert_equal("something! big, ", text)
	  assert_equal('>', fr.current_char())
	end

  def test_parse
    arr = ["<html> <head> </head>"]
    arr << '<body float="left"> <a href = "www.yahoo.com"> Yahoo! </a> </body> </html>'
    mock_file = MockFile.new(arr)
    fr = FileReader.new(mock_file, "test_path")
    cp = HTMLParser.new(fr)
    head = cp.parse()
    assert_equal(HTMLNodeType::HTML, head.type)
    assert_equal(2, head.children.length)
    assert_equal(HTMLNodeType::HEAD, head.children[0].type)
    assert_equal(HTMLNodeType::BODY, head.children[1].type)
    assert_equal("left", head.children[1].attributes["float"])
    assert_equal(HTMLNodeType::A, head.children[1].children[0].type)
    assert_equal("www.yahoo.com", head.children[1].children[0].attributes["href"])
    assert_equal("Yahoo! ", head.children[1].children[0].children[0].text)
  end

  def test_get_css
    arr = ["<html> <head> "]
    arr << '<link rel="stylesheet" type="text/css" href="css/small.css" />'
    arr << "</head>"
    arr << "</html> "
    mock_file = MockFile.new(arr)
    fr = FileReader.new(mock_file, "test_path")
    cp = HTMLParser.new(fr)
    head = cp.parse()
    css_arr = cp.get_css(head)
    assert_equal(1, css_arr.length)
  end
end

