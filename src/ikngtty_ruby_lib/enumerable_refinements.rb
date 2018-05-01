module IkngttyRubyLib
  module EnumerableRefinements
    refine Enumerable do
      def empty?
        self.first(1).length == 0
      end

      # Similar to reversed "take_while", so to say "take_unless",
      # but takes one more element, which evaluates to true first.
      def take_break_if(&block)
        Enumerator.new do |y|
          took = []
          self.each do |element|
            took << element
            break if y.yield(element)
          end
          took
        end.each(&block)
      end
    end

    refine Enumerator::Lazy do
      def take_break_if(&block)
        Enumerator.new do |y_for_break|
          Enumerator.new do |y_for_take|
            self.each do |element|
              y_for_take << element
              break if y_for_break.yield(element)
            end
          end.lazy
        end.lazy.each(&block)
      end
    end

    refine Array do
      # A nondestructive "delete" method.
      def remove(val, &block)
        dup = self.dup
        dup.delete(val, &block)
        dup
      end

      # A nondestructive "delete_at" method.
      def remove_at(pos)
        dup = self.dup
        dup.delete_at(pos)
        dup
      end
    end
  end
end
