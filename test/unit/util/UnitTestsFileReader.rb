require 'test/unit'
require_relative '../../../lib/Toygine.rb'
require_relative '../mocks/MockFile.rb'

class UnitTestsFileReader <Test::Unit::TestCase
  def test_consume_word
    mock_file = MockFile.new(["Hello"])
    fr = FileReader.new(mock_file, "test_path")
    word = fr.consume_word()
    assert_equal(word, "Hello")
  end

end

