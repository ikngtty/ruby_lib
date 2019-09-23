# frozen_string_literal: true

module IkngttyRubyLib
  module KernelRefinements
    refine Kernel do
      def def_order(setup:, teardown:, main:)
        setup.call
        main.call
        teardown.call
      end
    end
  end
end
