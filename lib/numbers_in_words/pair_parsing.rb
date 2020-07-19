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

    def compressed
      compress(ints)
    end

    # [40, 2] => [42]
    def compress(ints)
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

    def compress_int(int, sequel)
      tens = (int % 10).zero? && int > 10
      return [int + sequel, 2] if tens && sequel < 10

      [int, 1]
    end
  end
end
