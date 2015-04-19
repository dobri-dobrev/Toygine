require 'test/unit'
require_relative '../../../lib/Toygine.rb'

class UnitTestsMatchedRule <Test::Unit::TestCase
  def test_initialize
    rule = CSSRule.new()
    spec = Specificity.new(1,2,3)
    matched_rule = MatchedRule.new(spec, rule)
    assert_equal(rule, matched_rule.rule)
    assert_equal(spec, matched_rule.specificity)
  end

  def test_eql
  	rule1 = CSSRule.new()
  	sel11 = CSSSelector.new()
    sel11.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::P)
    sel11.add_tag(CSSSelectorType::CLASS, "test")
    sel11.add_tag(CSSSelectorType::CLASS, "cl")
    sel12 = CSSSelector.new()
    sel12.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::A)
    rule1.add_selector(sel11)
    rule1.add_selector(sel12)
    rule1.sort_selectors!()

    mr1 = MatchedRule.new(Specificity.new(0,2,1), rule1)
    mr2 = MatchedRule.new(Specificity.new(0,2,1), rule1)

    assert_equal(true, (mr1.eql? mr2))
  end
    

end

