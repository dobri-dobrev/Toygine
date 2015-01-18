class CSSValue
  attr_accessor :type, :r, :g, :b, :length, :unit, :keyword
  
  def initialize(t, options)
    @type = t
    case @type 
    when CSSValueType::COLORVALUE
      @r, @g, @b = options[:r], options[:g], options [:b]
    when CSSValueType::LENGTH
      @length, @unit = options[:length], options[:unit]
    when CSSValueType::KEYWORD
      @keyword = options[:word]
    end
  end

end

module CSSValueType
  KEYWORD = "KEYWORD"
  LENGTH = "LENGTH"
  COLORVALUE = "COLORVALUE"
end

module CSSLengthUnitType
  UNIT_TYPES = ["px", "pt"]
end