require 'test/unit'
require_relative '../lib/Toygine.rb'

class UnitTestsCSSDeclaration <Test::Unit::TestCase
  def test_initialization
  	cd = CSSDeclaration.new("name", "value")
  	assert_equal(cd.name, "name")
  	assert_equal(cd.value, "value")
  	assert_not_equal(cd.name, "value")
  end
  def test_to_s
  	value_object = CSSValue.new("value", {})
  	cd = CSSDeclaration.new("name", value_object)
  	assert_equal(cd.to_s, "name value\n")
  end
end
