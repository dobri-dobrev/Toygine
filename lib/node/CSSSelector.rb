class CSSSelector
  attr_accessor :ids, :classes, :tag_names, :specificity
  def initialize
    @ids = []
    @classes = []
    @tag_names = []
    @specificity = Specificity.new(0, 0, 0)
  end

  def add_tag(type, tag)
    case type
    when CSSSelectorType::ID
      @specificity.id += 1
      @ids.push(tag)
    when CSSSelectorType::CLASS
      @specificity.cl += 1
      @classes.push(tag)
    when CSSSelectorType::TAG_NAME
      @specificity.ta += 1
      @tag_names.push(tag)
    end 
  end

  def <=>(other)
    return @specificity <=> other.specificity
  end

  def to_s
    out = ""
    for id in @ids
      out += id + "_"
    end
    for clas in @classes
      out += clas + "_"
    end
    for tag_name in @tag_names
      out += tag_name + "_"
    end
    if out.eql? ""
      out = "empty selector"
    end
    out += @specificity.to_s
    out += "!"
    return out
  end
end

module CSSSelectorType
  ID = "id"
  CLASS = "class"
  TAG_NAME = "tag_name"
end