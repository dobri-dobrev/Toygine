class CSSValue
  attr_accessor :type, :r, :g, :b, :length, :unit, :keyword
  def initialize(t, options)
    @type = t
    @opt = options
    case @type 
    when CSSValueType::COLORVALUE
      @r, @g, @b = options[:r], options[:g], options [:b]
    when CSSValueType::LENGTH
      @length, @unit = options[:length], options[:unit]
    when CSSValueType::KEYWORD
      @keyword = options[:word]
    end
  end

  def to_px
    if @type == CSSValueType::LENGTH
      return @length #implement unit conversions
    else
      return 0.0
    end
  end

  def clone
    return CSSValue.new(@type, @opt.clone)
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