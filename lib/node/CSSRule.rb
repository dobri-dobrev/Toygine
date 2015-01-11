class CSSRule
  attr_accessor :selector, :declarations
  def initialize
    @declarations = []
  end
  def set_selector(sel)
    @selector = sel
  end
  def add_declaration(dec)
    @declarations.push(dec)
  end

  def to_s
    out = "CSS RULE \n"
    out += "Selectors: "
    out += @selector.to_s 
    out += "\n"
    for d in @declarations
      out += d.name + " " + d.value.type + "\n"
    end
    out += "\n"
  end
end

