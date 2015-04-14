require 'test/unit'
require_relative '../../../lib/Toygine.rb'
require_relative '../mocks/MockFile.rb'

class UnitTestsFileReader <Test::Unit::TestCase
  def test_initialize
  	mock_file = MockFile.new(["Hello"])
  	fr = FileReader.new(mock_file, "test_path")
  	assert_equal(fr.current_char(), "H")
  end
  def test_next_char
  	mock_file = MockFile.new(["Hello"])
  	fr = FileReader.new(mock_file, "test_path")
  	assert_equal(fr.next_char(), "e")
  end
  def test_consume_word
    mock_file = MockFile.new(["Hello"])
    fr = FileReader.new(mock_file, "test_path")
    word = fr.consume_word()
    assert_equal(word, "Hello")
    mock_file = MockFile.new(["Hello World"])
    fr = FileReader.new(mock_file, "test_path")
    word = fr.consume_word()
    assert_equal(word, "Hello")
    assert_equal(fr.current_char(), " ")
  end

  def test_skip_white_space
    mock_file = MockFile.new(["H    ello"])
    fr = FileReader.new(mock_file, "test_path")
    fr.consume_next_obl()
    fr.skip_white_space()
    assert_equal(fr.current_char(), "e")
  end


end

