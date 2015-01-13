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
  def add_declaration(dec)
    @declarations.push(dec)
  end

  def to_s
    out = "CSS RULE \n"
    out += "Selectors: "
    #TODO add multiple selector support
    out += @selector.to_s 
    out += "\n"
    for d in @declarations
      out += d.to_s()
    end
    out += "\n"
  end
end

