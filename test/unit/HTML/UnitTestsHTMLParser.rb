require 'test/unit'
require_relative '../../../lib/Toygine.rb'
require_relative '../mocks/MockFile.rb'

class UnitTestsHTMLParser <Test::Unit::TestCase
  def test_initialize
    mock_file = MockFile.new(["Hello"])
    fr = FileReader.new(mock_file, "test_path")
    cp = HTMLParser.new(fr)
  end
  
end

