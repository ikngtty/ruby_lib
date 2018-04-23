require 'test/unit'
require_relative '../../src/ikngtty_ruby_lib/enumerable_refinements'

module IkngttyRubyLibTest
  class EnumerableRefinementsTest < Test::Unit::TestCase
    using IkngttyRubyLib::EnumerableRefinements

    def test_enumerable_empty?
      # Not empty.
      lambda do
        enum = [1, 2, 4].lazy.select(&:odd?)
        assert_equal(Enumerator::Lazy, enum.class)
        assert_equal(1, enum.count)

        assert_equal(false, enum.empty?)
      end.call

      # Empty.
      lambda do
        enum = [0, 2, 4].lazy.select(&:odd?)
        assert_equal(Enumerator::Lazy, enum.class)
        assert_equal(0, enum.count)

        assert_equal(true, enum.empty?)
      end.call

      # Not empty but a member is nil.
      lambda do
        enum = [nil].lazy.select(&:nil?)
        assert_equal(Enumerator::Lazy, enum.class)
        assert_equal(1, enum.count)
        assert_equal(nil, enum.first)

        assert_equal(false, enum.empty?)
      end.call
    end

    def test_array_remove_without_block
      src = [10, 20, 30, 40]

      dist = src.remove(20)
      assert_equal([10, 20, 30, 40], src)
      assert_equal([10, 30, 40], dist)
    end

    def test_array_remove_with_block
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

    def test_array_remove_at
      src = [10, 20, 30, 40]

      dist = src.remove_at(2)
      assert_equal([10, 20, 30, 40], src)
      assert_equal([10, 20, 40], dist)
    end
  end

  class EnumerableRefinementsTestWithoutUsing < Test::Unit::TestCase
    def test_enumerable_empty?
      enum = [1, 2, 3].lazy
      assert_equal(Enumerator::Lazy, enum.class)

      assert_raise(NoMethodError) { enum.empty? }
    end
    def test_array_remove
      assert_raise(NoMethodError) { [].remove(0) }
    end
    def test_array_remove_at
      assert_raise(NoMethodError) { [].remove_at(0) }
    end
  end
end
