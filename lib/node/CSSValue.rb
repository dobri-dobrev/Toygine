class CSSValue
  attr_accessor :type, :r, :g, :b, :length, :unit
  
  def initialize(t, options)
    @type = t
    case @type #TODO add options 1 and 2
    when CSSValueType::COLORVALUE
      @r, @g, @b = options[:r], options[:g], options [:b]
    when CSSValueType::LENGTH
      @length, @unit = options[:length], options[:unit]
    end
  end

end

module CSSValueType
  KEYWORD = "KEYWORD"
  LENGTH = "LENGTH"
  COLORVALUE = "COLORVALUE"
end

module CSSUnitType
  PX = "px"
  PT = "pt"
end