module IkngttyRubyLib
  class SeqRange
    attr_reader :from, :to

    def initialize(from, to)
      @from = from
      @to = to
    end

    def length
      self.to - self.from + 1
    end

    def include?(item)
      self.from <= item && item <= self.to
    end

    def &(other)
      new_from = [self.from, other.from].max
      new_to = [self.to, other.to].min

      if new_from > new_to
        nil
      else
        SeqRange.new(new_from, new_to)
      end
    end

    def slide(delta)
      SeqRange.new(self.from + delta, self.to + delta)
    end
  end
end
