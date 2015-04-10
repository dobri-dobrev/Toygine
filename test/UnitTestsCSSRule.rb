require 'test/unit'
require_relative '../lib/Toygine.rb'

class UnitTestsCSSRule <Test::Unit::TestCase
  def test_initializer
    rule = CSSRule.new
    assert_equal(rule.selectors, [])
    assert_equal(rule.declarations, [])
  end

  def test_add_selector
    rule = CSSRule.new
    assert_equal(rule.selectors, [])
    assert_equal(rule.declarations, [])
    sel = CSSSelector.new
    sel.add_tag(CSSSelectorType::ID, "a")
    rule.add_selector(sel)
    assert_equal(rule.selectors[0], sel)
  end

  def test_add_declaration
    rule = CSSRule.new
    assert_equal(rule.selectors, [])
    assert_equal(rule.declarations, [])
    declaration = CSSDeclaration.new("a", "b")
    rule.add_declaration(declaration)
    assert_equal(rule.declarations[0], declaration)
  end
end
