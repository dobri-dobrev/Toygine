class CSSParser
  def initialize(file_p)
    @file_path = file_p
    @fr = FileReader.new(@file_path)
  end
  def parse
    @fr.skip_white_space()
    @ss = []
    # while @fr.has_next()
      selector = parse_selector()
      @fr.skip_white_space()
      @fr.consume_next_obl() # skip {
      @fr.skip_white_space()
    # end
  end

  def parse_selector
    if @fr.current_char().eql? "#"
      @fr.consume_next_obl()
      return CSSSelector.new(@fr.consume_word(), nil, nil)
    end
    if @fr.current_char().eql? "."
      @fr.consume_next_obl()
      return CSSSelector.new(nil, @fr.consume_word(), nil)
    end
    if ! @fr.current_char().eql? "{"
      return CSSSelector.new(nil, nil, @fr.consume_word())
    end
    if @fr.current_char().eql? "*"
      @fr.consume_next_obl()
      return CSSSelector.new(nil, "*", nil)
    end
    raise "Malformed CSS in " + @file_path
  end
end