require 'test/unit'
require_relative '../../../lib/Toygine.rb'
require_relative '../mocks/MockFile.rb'

class UnitTestsCSSParser <Test::Unit::TestCase
  def test_initializer
    mock_file = MockFile.new(["Hello"])
  	fr = FileReader.new(mock_file, "test_path")
  	cp = CSSParser.new(fr)
  end
end
