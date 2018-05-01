require 'test/unit'
require_relative '../../src/ikngtty_ruby_lib/enumerable_refinements'

module IkngttyRubyLibTest
  class EnumerableRefinementsTest < Test::Unit::TestCase
    using IkngttyRubyLib::EnumerableRefinements

    def test_enumerable_empty?
      # Not empty.
      lambda do
        enumerator = [1, 2, 4].lazy.select(&:odd?)
        assert_equal(Enumerator::Lazy, enumerator.class)
        assert_equal(1, enumerator.count)

        assert_equal(false, enumerator.empty?)
      end.call

      # Empty.
      lambda do
        enumerator = [0, 2, 4].lazy.select(&:odd?)
        assert_equal(Enumerator::Lazy, enumerator.class)
        assert_equal(0, enumerator.count)

        assert_equal(true, enumerator.empty?)
      end.call

      # Not empty but a member is nil.
      lambda do
        enumerator = [nil].lazy.select(&:nil?)
        assert_equal(Enumerator::Lazy, enumerator.class)
        assert_equal(1, enumerator.count)
        assert_equal(nil, enumerator.first)

        assert_equal(false, enumerator.empty?)
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

      # Remove nohing
      lambda do
        block_called = false

        dist = src.remove(25) { block_called = true }
        assert_equal([10, 20, 30, 40], src)
        assert_equal([10, 20, 30, 40], dist)
        assert_equal(true, block_called)
      end.call

      # Remove something
      lambda do
        block_called = false

        dist = src.remove(20) { block_called = true }
        assert_equal([10, 20, 30, 40], src)
        assert_equal([10, 30, 40], dist)
        assert_equal(false, block_called)
      end.call
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
      assert_equal(false, Enumerable.method_defined?(:empty?))
    end
    def test_array_remove
      assert_equal(false, Array.method_defined?(:remove))
    end
    def test_array_remove_at
      assert_equal(false, Array.method_defined?(:remove_at))
    end
  end
end
