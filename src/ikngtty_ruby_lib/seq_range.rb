# frozen_string_literal: true

module IkngttyRubyLib
  class SeqRange
    attr_reader :from, :to

    def initialize(from, to)
      @from = from
      @to = to
    end

    def length
      to - from + 1
    end

    def include?(item)
      from <= item && item <= to
    end

    def &(other)
      new_from = [from, other.from].max
      new_to = [to, other.to].min

      if new_from > new_to
        nil
      else
        SeqRange.new(new_from, new_to)
      end
    end

    def slide(delta)
      SeqRange.new(from + delta, to + delta)
    end
  end
end
