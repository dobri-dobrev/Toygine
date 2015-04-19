require 'test/unit'
require_relative '../../../lib/Toygine.rb'

class UnitTestsStyleTransformer <Test::Unit::TestCase
  def test_matches_simple_selector
    sel = CSSSelector.new()
    sel.add_tag(CSSSelectorType::ID, "name")
    sel.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::A)
    html_node = Node.new(HTMLNodeType::A, {"id" => "name"}, [], nil)
    assert_equal(true, StyleTransformer.matches_simple_selector(html_node, sel))
    
    html_node = Node.new(HTMLNodeType::A, {}, [], nil)
    assert_equal(false, StyleTransformer.matches_simple_selector(html_node, sel))

    sel = CSSSelector.new()
    sel.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::BODY)
    html_node = Node.new(HTMLNodeType::A, {}, [], nil)
    assert_equal(false, StyleTransformer.matches_simple_selector(html_node, sel))

    html_node = Node.new(HTMLNodeType::A, {"class" => "testclass cl"}, [], nil)
    sel = CSSSelector.new()
    sel.add_tag(CSSSelectorType::CLASS, "testclass")
    assert_equal(true, StyleTransformer.matches_simple_selector(html_node, sel))

    sel = CSSSelector.new()
    sel.add_tag(CSSSelectorType::CLASS, "somethingelse")
    assert_equal(false, StyleTransformer.matches_simple_selector(html_node, sel))
  end
  def test_match_rule
    rule = CSSRule.new()
    sel1 = CSSSelector.new()
    sel1.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::A)
    sel1.add_tag(CSSSelectorType::CLASS, "testclass")
    sel1.add_tag(CSSSelectorType::CLASS, "cl")
    sel2 = CSSSelector.new()
    sel2.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::BODY)
    sel2.add_tag(CSSSelectorType::CLASS, "cl")
    rule.add_selector(sel1)
    rule.add_selector(sel2)
    rule.sort_selectors!()
    html_node = Node.new(HTMLNodeType::A, {"class" => "testclass cl"}, [], nil)
    mr = MatchedRule.new(Specificity.new(0, 2, 1), rule)
    assert_equal(mr.rule, StyleTransformer.match_rule(html_node, rule).rule)
    assert_equal(mr.specificity, StyleTransformer.match_rule(html_node, rule).specificity)

    mr = MatchedRule.new(Specificity.new(0, 1, 1), rule)
    assert_not_equal(mr.specificity, StyleTransformer.match_rule(html_node, rule).specificity)

    html_node = Node.new(HTMLNodeType::BODY, {"class" => "cl"}, [], nil)
    assert_equal(mr.specificity, StyleTransformer.match_rule(html_node, rule).specificity)

    html_node = Node.new(HTMLNodeType::P, {"class" => "cl"}, [], nil)
    assert_equal(nil, StyleTransformer.match_rule(html_node, rule))
  end

  def test_matching_rules
    html_node = Node.new(HTMLNodeType::P, {"class" => "test cl"}, [], nil)

    rule1 = CSSRule.new()
    rule2= CSSRule.new()
    rule3 = CSSRule.new()

    sel11 = CSSSelector.new()
    sel11.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::P)
    sel11.add_tag(CSSSelectorType::CLASS, "test")
    sel11.add_tag(CSSSelectorType::CLASS, "cl")
    sel12 = CSSSelector.new()
    sel12.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::A)
    rule1.add_selector(sel11)
    rule1.add_selector(sel12)
    rule1.sort_selectors!()

    sel21 = CSSSelector.new()
    sel21.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::P)
    sel21.add_tag(CSSSelectorType::CLASS, "test")
    rule2.add_selector(sel21)
    rule2.sort_selectors!()

    sel31 = CSSSelector.new()
    sel31.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::BODY)
    sel31.add_tag(CSSSelectorType::CLASS, "test")
    rule3.add_selector(sel31)
    rule3.sort_selectors!()

    mr1 = MatchedRule.new(Specificity.new(0,2,1), rule1)
    mr2 = MatchedRule.new(Specificity.new(0,1,1), rule2)
    mr3 = MatchedRule.new(Specificity.new(0,1,1), rule3)

    assert(([mr1, mr2].eql? StyleTransformer.matched_rules(html_node,[rule1, rule2, rule3])), "matching_rules does not return correct first mr")
    assert(!([mr2, mr3].eql? StyleTransformer.matched_rules(html_node,[rule1, rule2, rule3])), "matching_rules returns wrong set of mrs")
    assert(!([mr2, mr1].eql? StyleTransformer.matched_rules(html_node,[rule1, rule2, rule3])), "matching_rules returns flipped list of mrs")
    
  end

  def test_get_sorted_matched_rules
    html_node = Node.new(HTMLNodeType::P, {"class" => "test cl"}, [], nil)

    rule1 = CSSRule.new()
    rule2= CSSRule.new()
    rule3 = CSSRule.new()

    sel11 = CSSSelector.new()
    sel11.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::P)
    sel11.add_tag(CSSSelectorType::CLASS, "test")
    sel11.add_tag(CSSSelectorType::CLASS, "cl")
    sel12 = CSSSelector.new()
    sel12.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::A)
    rule1.add_selector(sel11)
    rule1.add_selector(sel12)
    rule1.sort_selectors!()

    sel21 = CSSSelector.new()
    sel21.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::P)
    rule2.add_selector(sel21)
    rule2.sort_selectors!()

    sel31 = CSSSelector.new()
    sel31.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::P)
    sel31.add_tag(CSSSelectorType::CLASS, "test")
    rule3.add_selector(sel31)
    rule3.sort_selectors!()

    mr1 = MatchedRule.new(Specificity.new(0,2,1), rule1)
    mr2 = MatchedRule.new(Specificity.new(0,0,1), rule2)
    mr3 = MatchedRule.new(Specificity.new(0,1,1), rule3)

    mrs = StyleTransformer.get_sorted_matched_rules(html_node, [rule1, rule2, rule3])

    assert(([mr2, mr3, mr1].eql? StyleTransformer.get_sorted_matched_rules(html_node, [rule1, rule2, rule3])), "sorting is broken")
  end

  def test_specified_values
    html_node = Node.new(HTMLNodeType::P, {"class" => "test cl"}, [], nil)

    rule1 = CSSRule.new()
    rule2= CSSRule.new()
    rule3 = CSSRule.new()

    sel11 = CSSSelector.new()
    sel11.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::P)
    sel11.add_tag(CSSSelectorType::CLASS, "test")
    sel11.add_tag(CSSSelectorType::CLASS, "cl")
    rule1.add_selector(sel11)
    rule1.add_declaration(CSSDeclaration.new("margin-left", CSSValue.new(CSSValueType::LENGTH, {:length => 20, :unit => "pt"})))
    rule2.add_declaration(CSSDeclaration.new("color", CSSValue.new(CSSValueType::COLORVALUE, {:r => 10, :g => 11, :b => 12})))
    rule1.sort_selectors!()

    sel21 = CSSSelector.new()
    sel21.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::P)
    rule2.add_selector(sel21)
    rule2.add_declaration(CSSDeclaration.new("margin-left", CSSValue.new(CSSValueType::LENGTH, {:length => 10, :unit => "pt"})))
    rule2.add_declaration(CSSDeclaration.new("float", CSSValue.new(CSSValueType::KEYWORD, {:word => "left"})))
    rule2.sort_selectors!()

    sel31 = CSSSelector.new()
    sel31.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::P)
    sel31.add_tag(CSSSelectorType::CLASS, "test_other")
    rule3.add_selector(sel31)
    rule3.add_declaration(CSSDeclaration.new("float", CSSValue.new(CSSValueType::KEYWORD, {:word => "right"})))
    rule3.sort_selectors!()

    values = StyleTransformer.specified_values(html_node, [rule1, rule2, rule3])
    assert_equal("left",values["float"].keyword)
    assert_equal(20 ,values["margin-left"].length)
    assert_equal(10 ,values["color"].r)

  end

  def test_style_tree
    html_node = Node.new(HTMLNodeType::DIV, {"class" => "test cl"}, [], nil)
    html_node.add_child(Node.new(HTMLNodeType::A, {"class" => "test"}, [], nil) )
    html_node.add_child(Node.new(HTMLNodeType::A, {"class" => "cl"}, [], nil) )

    rule1 = CSSRule.new()
    rule2= CSSRule.new()
    rule3 = CSSRule.new()
    rule4 = CSSRule.new()

    rules = []

    sel11 = CSSSelector.new()
    sel11.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::DIV)
    sel11.add_tag(CSSSelectorType::CLASS, "test")
    sel11.add_tag(CSSSelectorType::CLASS, "cl")
    rule1.add_selector(sel11)
    rule1.add_declaration(CSSDeclaration.new("color", CSSValue.new(CSSValueType::COLORVALUE, {:r => 10, :g => 11, :b => 12})))
    rule1.sort_selectors!()
    rules << rule1

    sel21 = CSSSelector.new()
    sel21.add_tag(CSSSelectorType::CLASS, "test")
    rule2.add_selector(sel21)
    rule2.add_declaration(CSSDeclaration.new("width", CSSValue.new(CSSValueType::LENGTH, {:length => 100, :unit => "pt"})))
    rule2.sort_selectors!()
    rules << rule2

    sel31 = CSSSelector.new()
    sel31.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::A)
    rule3.add_selector(sel31)
    rule3.add_declaration(CSSDeclaration.new("float", CSSValue.new(CSSValueType::KEYWORD, {:word => "right"})))
    rule3.sort_selectors!()
    rules << rule3

    sel41 = CSSSelector.new()
    sel41.add_tag(CSSSelectorType::TAG_NAME, HTMLNodeType::A)
    sel41.add_tag(CSSSelectorType::CLASS, "cl")
    rule4.add_selector(sel41)
    rule4.add_declaration(CSSDeclaration.new("height", CSSValue.new(CSSValueType::LENGTH, {:length => 10, :unit => "pt"})))
    rule4.sort_selectors!()
    rules << rule4

    st = StyleTransformer.style_tree(html_node, rules)

    assert_equal(10, st.value("color").r)
    assert_equal(100, st.value("width").length)
    assert_equal(nil, st.value("float"))
    assert_equal(nil, st.value("height"))

    assert_equal(nil, st.children[0].value("color"))
    assert_equal(100, st.children[0].value("width").length)
    assert_equal("right", st.children[0].value("float").keyword)
    assert_equal(nil, st.children[0].value("height"))

    assert_equal(nil, st.children[1].value("color"))
    assert_equal(nil, st.children[1].value("width"))
    assert_equal("right", st.children[1].value("float").keyword)
    assert_equal(10, st.children[1].value("height").length)
  end

  def test_style_tree_2
    html_node = Node.new(HTMLNodeType::DIV, {"class" => "test cl"}, [], nil)
    html_node.add_child(Node.new(HTMLNodeType::A, {"class" => "test"}, [], nil) )
    html_node.add_child(Node.new(HTMLNodeType::A, {"class" => "cl"}, [], nil) )

    rules = []

    st = StyleTransformer.style_tree(html_node, rules)

    assert_equal(nil, st.value("color"))
    assert_equal(nil, st.value("width"))
    assert_equal(nil, st.value("float"))
    assert_equal(nil, st.value("height"))
  end


end

