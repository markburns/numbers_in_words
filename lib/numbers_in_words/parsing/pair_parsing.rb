# frozen_string_literal: true

module NumbersInWords
  class PairParsing
    attr_accessor :ints
    attr_reader :only_compress

    def initialize(ints, only_compress)
      @ints = ints
      @only_compress = only_compress
    end

    # 15,16
    # 85,16
    def pair_parse
      ints = compressed
      return ints if only_compress

      return ints[0] if ints.length == 1

      sum = 0

      ints.each do |n|
        sum *= n >= 10 ? 100 : 10
        sum += n
      end

      sum
    end

    private

    # [40, 2] => [42]
    def compressed
      return [] if ints.empty?

      result = []
      index = 0

      index, result = compress_numbers(result, index)

      result << ints[-1] if index < ints.length

      result
    end

    def compress_numbers(result, index)
      while index < ints.length - 1
        int, jump = compress_int(ints[index], ints[index + 1])
        result << int
        index += jump
      end

      [index, result]
    end

    def compress_int(int, next_int)
      tens = (int % 10).zero? && int > 10
      return [int + next_int, 2] if tens && next_int < 10

      [int, 1]
    end
  end
end
