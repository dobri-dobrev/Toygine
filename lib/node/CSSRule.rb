class CSSRule
  attr_accessor :selectors, :declarations
  def initialize
    @selectors = []
    @declarations = []
  end
  def add_selector(sel)
    @selectors.push(sel)
  end
  def add_declaration(dec)
    @declarations.push(dec)
  end

  def to_s
    out = "CSS RULE \n"
    out += "Selectors: "
    for s in @selectors
      out += s.to_s + " "
    end
    out += "\n"
    for d in @declarations
      out += d.name + " " + d.value.type + "\n"
    end
    out += "\n"
  end
end

