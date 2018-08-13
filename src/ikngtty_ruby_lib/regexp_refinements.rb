module IkngttyRubyLib
  module RegexpRefinements
    refine Regexp do
      # Enumerate all match data.
      def each_match(str, &block)
        Enumerator.new do |y|
          while (match = self.match(str))
            str = match.post_match
            y << match
          end
        end.lazy.each(&block)
      end

      # Return all match data.
      def matches(str)
        self.each_match(str).to_a
      end
    end
  end
end
