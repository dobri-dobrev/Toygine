require 'test/unit'
require_relative '../lib/Toygine.rb'

class CssParserTest <Test::Unit::TestCase
  def test_initial
    cp = CSSParser.new(FileReader.new("test/test_pages/css/small.css"))
    cl = cp.parse()
    for rule in cl
    	puts rule
    end
  end
end