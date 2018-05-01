module IkngttyRubyLib
  module AssersionsRefinements
    refine Test::Unit::Assertions do
      # NOTE: Do not use 'assert' cuz it cannot overwrite an error message
      # completely. Use 'assert_block' insteadly.

      def assert_not(test, message = '<true> is not false.')
        assert_block(message) { !test }
      end
    end
  end
end
