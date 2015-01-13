class CSSDeclaration
  attr_accessor :name, :value
  def initialize(n, v)
    @name = n
    @value = v
  end
  def to_s
    out = ""
    out += @name + " " + @value.type + "\n"
    return out
  end
end
