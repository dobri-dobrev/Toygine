class CSSParser
  def initialize(file_p)
    @file_path = file_p
    @fr = FileReader.new(@file_path)
  end
  def parse
    @fr.skip_white_space()
    @cr = []
    while @fr.has_next()
      @cr.push( parse_rule() )
      @fr.skip_white_space()
    end
    return @cr
  end

  def parse_rule
    @fr.skip_white_space()
    rule = CSSRule.new()
    rule.add_selector( parse_selector() )
    @fr.skip_white_space()
    @fr.consume_next_obl() # skip {
    @fr.skip_white_space()
    while ! @fr.current_char.eql? '}'
      rule.add_declaration( parse_declaration() )
    end
    if @fr.has_next()
      @fr.consume_next_obl()  #skip }
    end
    return rule
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

  def parse_declaration
    @fr.skip_white_space()
    name = @fr.consume_word()
    @fr.consume_next_obl() # skip :
    @fr.skip_white_space()
    case @fr.current_char()
    when "#"
      value = parse_color()
    when '0'..'9'
      value = parse_length()
    end
    @fr.consume_next_obl() # skip ;
    @fr.skip_white_space()
    return CSSDeclaration.new(name, value)
  end
  
  def parse_color()
    @fr.consume_next_obl() # skip #
    r = @fr.consume_and_advance()
    r += @fr.consume_and_advance()
    g = @fr.consume_and_advance()
    g += @fr.consume_and_advance()
    b = @fr.consume_and_advance()
    b += @fr.consume_and_advance()
    return CSSValue.new(CSSValueType::COLORVALUE, {:r => r.to_i, :g => g.to_i, :b => b.to_i})
  end

  def parse_length()
    num = ""
    while @fr.current_char() =~ /[[:digit:]]/
      num += @fr.consume_and_advance()
    end
    unit = @fr.consume_word()
    return CSSValue.new(CSSValueType::LENGTH, {:length => num.to_i, :unit => unit})
  end
end