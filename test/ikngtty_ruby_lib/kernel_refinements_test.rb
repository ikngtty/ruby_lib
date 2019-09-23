# frozen_string_literal: true

require 'test/unit'
require_relative '../../src/ikngtty_ruby_lib/assertions_refinements'
require_relative '../../src/ikngtty_ruby_lib/kernel_refinements'

using IkngttyRubyLib::AssertionsRefinements

module IkngttyRubyLibTest
  class KernelRefinementsTest < Test::Unit::TestCase
    using IkngttyRubyLib::KernelRefinements

    def test_def_order_normal
      a = []
      def_order(
        setup: lambda do
          a.push('setup')
        end,
        teardown: lambda do
          a.push('teardown')
        end,
        main: lambda do
          a.push('main')
        end
      )
      assert_equal(%w[setup main teardown], a)
    end

    def test_def_order_invalid_parameters
      assert_raise(ArgumentError) do
        a = []
        def_order(
          setdown: lambda do
            a.add(1)
          end,
          tearup: lambda do
            a.add(3)
          end,
          mein: lambda do
            a.add(2)
          end
        )
      end
    end
  end

  class KernelRefinementsTestWithoutUsing < Test::Unit::TestCase
    def test_def_order
      assert_not(Kernel.method_defined?(:def_order))
    end
  end
end
