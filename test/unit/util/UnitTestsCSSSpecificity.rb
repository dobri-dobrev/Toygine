require 'test/unit'

require_relative '../../../lib/Toygine.rb'

class UnitTestsCSSSpecificity <Test::Unit::TestCase
  def test_initial
    smaller = Specificity.new(1, 2, 3)
    bigger = Specificity.new(2, 1, 1)
    equal = Specificity.new(2, 1, 1)
    assert(smaller < bigger, "Smaller specificity is not smaller than bigger")
    assert(bigger > smaller, "Bigger specificity is not bigger than smaller")
    assert(! (bigger < smaller), "Bigger specificity is not bigger than smaller")
    assert(bigger == equal, "equal specificities are not equal")
  end

  def test_eql
  	smaller = Specificity.new(1, 2, 3)
    same = Specificity.new(1, 2, 3)
    assert_equal(true, (same.eql? smaller))
  end
end