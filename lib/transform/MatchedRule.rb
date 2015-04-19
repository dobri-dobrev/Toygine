class MatchedRule
  attr_accessor :specificity, :rule
  def initialize(spec, ru)
    @rule = ru
    @specificity = spec
  end

  def eql?(other)
    return (@rule.eql? other.rule and @specificity.eql? other.specificity)
  end
end