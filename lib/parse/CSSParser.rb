class CSSParser
  def initialize(file_reader)
    @fr = file_reader
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
    while true
      rule.add_selector( parse_selector() )  
      @fr.skip_white_space()
      case @fr.current_char()
      when ","
        @fr.consume_next_obl()
        @fr.skip_white_space()
      when "{" 
          break
      else
        raise "Malformed CSS selector in "+ @fr.path
      end
    end
    rule.sort_selectors!()
    @fr.consume_next_obl() # skip {
    @fr.skip_white_space()
    
    while ! @fr.current_char.eql? '}'
      rule.add_declaration( parse_declaration() )
      @fr.consume_next_obl() # move over ;
      @fr.skip_white_space()
    end
    if @fr.has_next()
      @fr.consume_next_obl()  #skip }
    end
    return rule
  end

  def parse_selector
    selector = CSSSelector.new()
    while true
      case @fr.current_char()
      when "#"
        @fr.consume_next_obl()
        selector.add_tag( CSSSelectorType::ID, @fr.consume_word() )
      when "."
        @fr.consume_next_obl()
        selector.add_tag( CSSSelectorType::CLASS, @fr.consume_word() )
      when "*"
        @fr.consume_next_obl()
      when /[[:alpha:]]/
        if @fr.has_next()
          selector.add_tag( CSSSelectorType::TAG_NAME, @fr.consume_word() )
        else
          @fr.skip_white_space()
          return selector  
        end
      else
        @fr.skip_white_space()
        return selector
      end
    end
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
    when /[[:alpha:]]/
      value = parse_key_word()
    end
    return CSSDeclaration.new(name, value)
  end
  
  def parse_color
    #TODO raise error if invalid hex
    r = @fr.consume_next_obl()
    r += @fr.consume_next_obl()
    g = @fr.consume_next_obl()
    g += @fr.consume_next_obl()
    b = @fr.consume_next_obl()
    b += @fr.consume_next_obl()
    if @fr.has_next()
      @fr.consume_next_obl() #move to ;  
    end
    return CSSValue.new(CSSValueType::COLORVALUE, {:r => r, :g => g, :b => b})
  end

  def parse_length
    num = ""
    while @fr.current_char() =~ /[[:digit:]]/
      num += @fr.current_char()
      @fr.consume_next_obl()
    end
    unit = @fr.consume_word()
    unless CSSLengthUnitType::UNIT_TYPES.include? unit
      raise "Malformed CSS length value in "+ @fr.path
    end
    return CSSValue.new(CSSValueType::LENGTH, {:length => num.to_i, :unit => unit})
  end

  def parse_key_word
    return CSSValue.new(CSSValueType::KEYWORD, {:word => @fr.consume_word()})
  end
end