# frozen_string_literal: true

module NumbersInWords
  class ParseFractions
    attr_reader :nums

    def initialize(nums)
      @nums = nums.map(&:to_f)
    end

    def call
      return if no_fractions?

      just_fraction || calculate
    end

    def calculate
      (parse(numbers) * parse(fractions)).rationalize(EPSILON).to_f
    end

    def parse(numbers)
      NumberParser.new.parse(numbers)
    end

    def numbers
      nums[0..index_of_fraction - 1]
    end

    def fractions
      nums[index_of_fraction..-1]
    end

    def just_fraction
      return nums.first if index_of_fraction.zero?
    end

    def index_of_fraction
      nums.index { |n| n < 1.0 }
    end

    def no_fractions?
      nums.all? { |n| n.zero? || n >= 1.0 }
    end
  end
end
