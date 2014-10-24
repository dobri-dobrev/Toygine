require 'test/unit'
require_relative '../lib/parse/CSSParser'
require_relative '../lib/util/FileReader'
require_relative '../lib/node/CSSSelector'

class CssParserTest <Test::Unit::TestCase
  def test_initial
    cp = CSSParser.new("test/test_pages/css/small.css")
    cp.parse()
  end
end