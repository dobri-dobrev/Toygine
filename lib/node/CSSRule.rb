class CSSRule
  attr_accessor :selectors, :selector, :declarations
  def initialize
    #TODO enable multiple selector chains
    @declarations = []
    @selectors = []
  end
  def set_selector(sel)
    @selector = sel
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
      out += s.to_s()  
    end
    out += "\n"
    for d in @declarations
      out += d.to_s()
    end
    out += "\n"
  end
end

