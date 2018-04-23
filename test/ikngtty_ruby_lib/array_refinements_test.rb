require 'test/unit'
require_relative '../../src/ikngtty_ruby_lib/array_refinements'

module IkngttyRubyLibTest
  class ArrayRefinementsTest < Test::Unit::TestCase
    using IkngttyRubyLib::ArrayRefinements

    def test_remove_without_block
      src = [10, 20, 30, 40]

      dist = src.remove(20)
      assert_equal([10, 20, 30, 40], src)
      assert_equal([10, 30, 40], dist)
    end

    def test_remove_with_block
      src = [10, 20, 30, 40]
      sub_effects_executed = Array.new(2, false)

      dist_no_remove = src.remove(25) { sub_effects_executed[0] = true }
      assert_equal([10, 20, 30, 40], src)
      assert_equal([10, 20, 30, 40], dist_no_remove)
      assert_equal(true, sub_effects_executed[0])

      dist_remove = src.remove(20) { sub_effects_executed[1] = true }
      assert_equal([10, 20, 30, 40], src)
      assert_equal([10, 30, 40], dist_remove)
      assert_equal(false, sub_effects_executed[1])
    end

    def test_remove_at
      src = [10, 20, 30, 40]

      dist = src.remove_at(2)
      assert_equal([10, 20, 30, 40], src)
      assert_equal([10, 20, 40], dist)
    end
  end

  class ArrayRefinementsTestWithoutUsing < Test::Unit::TestCase
    def test_remove
      assert_raise(NoMethodError) { [].remove(0) }
    end
    def test_remove_at
      assert_raise(NoMethodError) { [].remove_at(0) }
    end
  end
end
