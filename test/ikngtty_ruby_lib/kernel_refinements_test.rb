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
        setup: -> do
          a.push('setup')
        end,
        teardown: -> do
          a.push('teardown')
        end,
        main: -> do
          a.push('main')
        end
      )
      assert_equal(['setup', 'main', 'teardown'], a)
    end

    def test_def_order_invalid_parameters
      assert_raise(ArgumentError) do
        a = []
        def_order(
          setdown: -> do
            a.add(1)
          end,
          tearup: -> do
            a.add(3)
          end,
          mein: -> do
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
