class CSSValue
  def initialize(t, options)
    @type = t
    case @type #TODO add options 1 and 2
    when CSSValueType::COLORVALUE
      @r, @g, @b = options[:r], options[:g], options [:b]
    end
  end

end
module CSSValueType
  KEYWORD = 1
  LENGTH = 2
  COLORVALUE = 3
end