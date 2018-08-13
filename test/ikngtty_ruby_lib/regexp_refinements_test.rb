require 'test/unit'
require_relative '../../src/ikngtty_ruby_lib/assertions_refinements'
require_relative '../../src/ikngtty_ruby_lib/regexp_refinements'

using IkngttyRubyLib::AssertionsRefinements

module IkngttyRubyLibTest
  class RegexpRefinementsTest < Test::Unit::TestCase
    using IkngttyRubyLib::RegexpRefinements

    def test_each_match_with_block
      # Normal.
      lambda do
        matched = []
        captured = []
        /(\d+)a/.each_match('1abc 12abc 123abc') do |match|
          assert_equal(MatchData, match.class)
          matched << match[0]
          captured << match[1]
        end
        assert_equal(%w[1a 12a 123a], matched)
        assert_equal(%w[1 12 123], captured)
      end.call

      # No matching.
      lambda do
        assert_nothing_raised do
          /abc/.each_match('defghi') do
            raise 'An unexpected matching is occured.'
          end
        end
      end.call
    end

    def test_each_match_without_block
      matched = /(\d+)a/.each_match('1abc 12abc 123abc')
                .map { |match| match[1].to_i }
                .to_a
      assert_equal([1, 12, 123], matched)
    end

    def test_matches
      # Normal.
      lambda do
        matched = /(\d+)a/.matches('1abc 12abc 123abc')
        assert_equal('1a'   ,matched[0][0])
        assert_equal('12a'  ,matched[1][0])
        assert_equal('123a' ,matched[2][0])
        assert_equal('1'    ,matched[0][1])
        assert_equal('12'   ,matched[1][1])
        assert_equal('123'  ,matched[2][1])
      end.call

      # No matching.
      lambda do
        matched = /abc/.matches('defghi')
        assert_equal([], matched)
      end.call
    end
  end

  class RegexpRefinementsTestWithoutUsing < Test::Unit::TestCase
    def test_each_match
      assert_not(Regexp.method_defined?(:each_match))
    end
    def test_matches
      assert_not(Regexp.method_defined?(:matches))
    end
  end
end
