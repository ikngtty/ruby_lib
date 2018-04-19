module IkngttyRubyLib
  module ArrayRefinements
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

      # A nondestructive "delete_if" method.
      def remove_if(&block)
        dup = self.dup
        dup.delete_if(&block)
      end
    end
  end
end
