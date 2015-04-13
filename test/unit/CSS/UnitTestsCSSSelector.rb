require 'test/unit'
require_relative '../../../lib/Toygine.rb'

class UnitTestsCSSSelector <Test::Unit::TestCase
  def test_initialization
  	cs = CSSSelector.new()
  	assert_equal(cs.specificity.id, 0)
  	assert_equal(cs.specificity.cl, 0)
  	assert_equal(cs.specificity.ta, 0)
  end

  def test_add_id
    cs = CSSSelector.new()
    cs.add_tag(CSSSelectorType::ID, "a")
    assert_equal(cs.specificity.id, 1)
    assert_equal(cs.specificity.cl, 0)
    assert_equal(cs.specificity.ta, 0)
    assert_equal(cs.ids.size, 1)
    assert_not_equal(cs.classes.size, 1)
  end

  def test_add_class
    cs = CSSSelector.new()
    cs.add_tag(CSSSelectorType::CLASS, "a")
    assert_equal(cs.specificity.id, 0)
    assert_equal(cs.specificity.cl, 1)
    assert_equal(cs.specificity.ta, 0)
    assert_equal(cs.classes.size, 1)
    assert_not_equal(cs.ids.size, 1)
  end

  def test_add_tag
    cs = CSSSelector.new()
    cs.add_tag(CSSSelectorType::TAG_NAME, "a")
    assert_equal(cs.specificity.id, 0)
    assert_equal(cs.specificity.cl, 0)
    assert_equal(cs.specificity.ta, 1)
    assert_equal(cs.tag_names.size, 1)
    assert_not_equal(cs.ids.size, 1)
  end

  def test_to_s
    cs = CSSSelector.new
    assert_equal(cs.to_s, "empty selector(0, 0, 0)!")
    cs.add_tag(CSSSelectorType::ID, "id")
    assert_equal(cs.to_s, "id_(1, 0, 0)!")
  end

  def test_compare
    cs_smaller = CSSSelector.new
    cs_larger = CSSSelector.new
    cs_larger.add_tag(CSSSelectorType::ID, "id")
    cs_smaller.add_tag(CSSSelectorType::CLASS, "class")
    assert( cs_smaller < cs_larger, "CSSSelector comparison broken")
  end

end
