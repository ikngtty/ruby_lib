require 'test/unit'
require_relative '../../src/ikngtty_ruby_lib/assertions_refinements'
require_relative '../../src/ikngtty_ruby_lib/enumerable_refinements'

using IkngttyRubyLib::AssersionsRefinements

module IkngttyRubyLibTest
  class EnumerableRefinementsTest < Test::Unit::TestCase
    using IkngttyRubyLib::EnumerableRefinements

    def test_enumerable_empty?
      # Not empty.
      lambda do
        enumerator = [1, 2, 4].lazy.find_all(&:odd?)
        assert_equal(Enumerator::Lazy, enumerator.class)
        assert_equal(1, enumerator.count)

        assert_not(enumerator.empty?)
      end.call

      # Empty.
      lambda do
        enumerator = [0, 2, 4].lazy.find_all(&:odd?)
        assert_equal(Enumerator::Lazy, enumerator.class)
        assert_equal(0, enumerator.count)

        assert(enumerator.empty?)
      end.call

      # Not empty but a member is nil.
      lambda do
        enumerator = [nil].lazy.find_all(&:nil?)
        assert_equal(Enumerator::Lazy, enumerator.class)
        assert_equal(1, enumerator.count)
        assert_equal(nil, enumerator.first)

        assert_not(enumerator.empty?)
      end.call
    end

    def test_enumerable_take_break_if_with_block
      # Takes elements while took one evaluates to false, and at last
      # takes one which evaluates to true first.
      lambda do
        took = [10, 20, 30, 40, 50].take_break_if { |e| e >= 30 }
        assert_equal([10, 20, 30], took)
      end.call

      # Takes at least one element, even if all evaluate to true.
      lambda do
        took = [10, 20, 30, 40, 50].take_break_if { |e| e >= 0 }
        assert_equal([10], took)
      end.call

      # When nothing evaluates to true, takes all.
      lambda do
        took = [10, 20, 30, 40, 50].take_break_if { |e| e >= 100 }
        assert_equal([10, 20, 30, 40, 50], took)
      end.call

      # When empty, returns empty.
      lambda do
        took = [].take_break_if { |e| e >= 0 }
        assert_equal([], took)
      end.call
    end

    def test_enumerable_take_break_if_without_block
      will_take = [10, 20, 30, 40, 50].take_break_if
      assert_instance_of(Enumerator, will_take)

      took = will_take.with_index { |e, i| i >= 2 }
      assert_equal([10, 20, 30], took)
    end

    def test_enumerator_lazy_take_break_if_with_block
      # Takes elements while took one evaluates to false, and at last
      # takes one which evaluates to true first.
      lambda do
        took = [10, 20, 30, 40, 50].lazy.take_break_if { |e| e >= 30 }.force
        assert_equal([10, 20, 30], took)
      end.call

      # Takes at least one element, even if all evaluate to true.
      lambda do
        took = [10, 20, 30, 40, 50].lazy.take_break_if { |e| e >= 0 }.force
        assert_equal([10], took)
      end.call

      # When nothing evaluates to true, takes all.
      lambda do
        took = [10, 20, 30, 40, 50].lazy.take_break_if { |e| e >= 100 }.force
        assert_equal([10, 20, 30, 40, 50], took)
      end.call

      # When empty, returns empty.
      lambda do
        took = [].lazy.take_break_if { |e| e >= 0 }.force
        assert_equal([], took)
      end.call

      # Evaluates lazy.
      lambda do
        sub_effects = []

        will_take = [10, 20, 30, 40, 50].lazy.take_break_if do |e|
          sub_effects << 'first'
          e >= 30
        end
        assert_instance_of(Enumerator::Lazy, will_take)
        assert_equal([], sub_effects)

        took = will_take.find_all do |e|
          sub_effects << 'second'
          e % 20 == 10
        end.force
        assert_equal([10, 30], took)
        assert_equal(%w[
          second
          first
          second
          first
          second
          first
        ], sub_effects)
      end
    end

    def test_enumerator_lazy_take_break_if_without_block
      sub_effects = []

      will_will_take = [10, 20, 30, 40, 50].lazy.take_break_if
      assert_instance_of(Enumerator::Lazy, will_will_take)

      will_take = will_will_take.with_index do |e, i|
        sub_effects << 'first'
        i >= 2
      end
      assert_instance_of(Enumerator::Lazy, will_take)
      assert_equal([], sub_effects)

      took = will_take.find_all do |e|
        sub_effects << 'second'
        e % 20 == 10
      end.force
      assert_equal([10, 30], took)
      assert_equal(%w[
        second
        first
        second
        first
        second
        first
      ], sub_effects)
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
        assert(block_called)
      end.call

      # Remove something
      lambda do
        block_called = false

        dist = src.remove(20) { block_called = true }
        assert_equal([10, 20, 30, 40], src)
        assert_equal([10, 30, 40], dist)
        assert_not(block_called)
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
      assert_not(Enumerable.method_defined?(:empty?))
    end
    def test_enumerable_take_break_if
      assert_not(Enumerable.method_defined?(:take_break_if))
    end
    def test_enumerator_lazy_take_break_if
      assert_not(Enumerator::Lazy.method_defined?(:take_break_if))
    end
    def test_array_remove
      assert_not(Array.method_defined?(:remove))
    end
    def test_array_remove_at
      assert_not(Array.method_defined?(:remove_at))
    end
  end
end
