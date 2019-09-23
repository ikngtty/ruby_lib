# frozen_string_literal: true

require 'test/unit'
require_relative '../../src/ikngtty_ruby_lib/seq_range'
require_relative '../../src/ikngtty_ruby_lib/assertions_refinements'

using IkngttyRubyLib::AssertionsRefinements

module IkngttyRubyLibTest
  class SeqRangeTest < Test::Unit::TestCase
    def setup
      @seq = IkngttyRubyLib::SeqRange.new(8, 12)
    end

    def test_attr
      assert_equal 8, @seq.from
      assert_equal 12, @seq.to
      assert_equal 5, @seq.length
    end

    def test_include
      assert_not  @seq.include?(4)
      assert_not  @seq.include?(7)
      assert      @seq.include?(8)
      assert      @seq.include?(10)
      assert      @seq.include?(12)
      assert_not  @seq.include?(13)
      assert_not  @seq.include?(16)
    end

    def test_and
      lambda do
        other = IkngttyRubyLib::SeqRange.new(4, 7)
        union = @seq & other
        assert_equal nil, union
      end.call
      lambda do
        other = IkngttyRubyLib::SeqRange.new(4, 8)
        union = @seq & other
        assert_equal 8, union.from
        assert_equal 8, union.to
      end.call
      lambda do
        other = IkngttyRubyLib::SeqRange.new(4, 11)
        union = @seq & other
        assert_equal 8, union.from
        assert_equal 11, union.to
      end.call
      lambda do
        other = IkngttyRubyLib::SeqRange.new(4, 12)
        union = @seq & other
        assert_equal 8, union.from
        assert_equal 12, union.to
      end.call
      lambda do
        other = IkngttyRubyLib::SeqRange.new(4, 16)
        union = @seq & other
        assert_equal 8, union.from
        assert_equal 12, union.to
      end.call
      lambda do
        other = IkngttyRubyLib::SeqRange.new(8, 8)
        union = @seq & other
        assert_equal 8, union.from
        assert_equal 8, union.to
      end.call
      lambda do
        other = IkngttyRubyLib::SeqRange.new(8, 11)
        union = @seq & other
        assert_equal 8, union.from
        assert_equal 11, union.to
      end.call
      lambda do
        other = IkngttyRubyLib::SeqRange.new(8, 12)
        union = @seq & other
        assert_equal 8, union.from
        assert_equal 12, union.to
      end.call
      lambda do
        other = IkngttyRubyLib::SeqRange.new(8, 16)
        union = @seq & other
        assert_equal 8, union.from
        assert_equal 12, union.to
      end.call
      lambda do
        other = IkngttyRubyLib::SeqRange.new(9, 11)
        union = @seq & other
        assert_equal 9, union.from
        assert_equal 11, union.to
      end.call
      lambda do
        other = IkngttyRubyLib::SeqRange.new(9, 12)
        union = @seq & other
        assert_equal 9, union.from
        assert_equal 12, union.to
      end.call
      lambda do
        other = IkngttyRubyLib::SeqRange.new(9, 16)
        union = @seq & other
        assert_equal 9, union.from
        assert_equal 12, union.to
      end.call
      lambda do
        other = IkngttyRubyLib::SeqRange.new(12, 12)
        union = @seq & other
        assert_equal 12, union.from
        assert_equal 12, union.to
      end.call
      lambda do
        other = IkngttyRubyLib::SeqRange.new(12, 16)
        union = @seq & other
        assert_equal 12, union.from
        assert_equal 12, union.to
      end.call
      lambda do
        other = IkngttyRubyLib::SeqRange.new(13, 16)
        union = @seq & other
        assert_equal nil, union
      end.call
    end

    def test_slide
      slided = @seq.slide(3)
      assert_equal 11, slided.from
      assert_equal 15, slided.to
    end
  end
end
