# frozen_string_literal: true

require 'forwardable'

module NumbersInWords
  class NumberParser
    # Example: 364,895,457,898
    # three hundred and sixty four billion eight hundred and ninety five million
    # four hundred and fifty seven thousand eight hundred and ninety eight
    #
    # 3 100 60 4 10^9, 8 100 90 5 10^6, 4 100 50 7 1000, 8 100 90 8
    #                                                                    memory answer
    # x1. 3 add to memory because answer and memory are zero                 3     0
    # x2. memory * 100 (because memory<100)                                  300   0
    # x3. 60 add to memory because memory > 60                               360   0
    # x3. 4 add to memory because memory > 4                                364    0
    # x4. multiply memory by 10^9 because memory < power of ten          364*10^9  0
    # x5. add memory to answer  (and reset)memory > 8 (memory pow of ten > 2) 0   364*10^9
    # x6. 8 add to memory because not finished                                8    ''
    # x7. multiply memory by 100 because memory < 100                        800   ''
    # x8. add 90 to memory because memory > 90                               890   ''
    # x9. add 5 to memory because memory > 5                                 895   ''
    # x10. multiply memory by 10^6 because memory < power of ten        895*10^6    ''
    # x11. add memory to answer (and reset) because memory power ten > 2       0    364895 * 10^6
    # x12. 4 add to memory because not finished                                4    ''
    # x13. memory * 100 because memory < 100                                 400    ''
    # x14. memory + 50 because memory > 50                                   450    ''
    # x15. memory + 7  because memory > 7                                    457    ''
    # x16. memory * 1000 because memory < 1000                            457000    ''
    # x17. add memory to answer  (and reset)memory > 8 (memory pow of ten > 2) 0   364895457000
    # x18. 8 add to memory because not finished                                8    ''
    # x19. memory * 100 because memory < 100                                 800    ''
    # x14. memory + 90 because memory > 90                                   890    ''
    # x15. memory + 8  because memory > 8                                    898    ''
    # 16. finished so add memory to answer

    # Example
    # 2001
    # two thousand and one
    # 2 1000 1
    #                                                        memory answer
    # 1. add 2 to memory because first                          2       0
    # 2. multiply memory by 1000 because memory < 1000        2000      0
    # 3. add memory to answer,reset,  because power of ten>2    0      2000
    # 4. add 1 to memory                                        1      2000
    # 5. finish - add memory to answer                          0      2001

    SCALES_N = [10**2, 10**3, 10**6, 10**9, 10**12, 10**100].freeze

    def parse(nums, only_compress: false)
      if nums.length < 2
        return nums if only_compress

        return nums.empty? ? 0 : nums[0]
      end

      return pair_parse(nums, only_compress) if (SCALES_N & nums).empty?

      parse_nums(nums)
    end

    def parse_nums(nums)
      status = ParseStatus.new

      nums.each do |num|
        ParseIndividualNumber.new(status, num).call
      end

      status.calculate
    end

    class ParseStatus
      attr_accessor :reset, :memory, :answer

      def initialize
        @reset = true
        @memory = 0
        @answer = 0
      end

      def calculate
        answer + memory
      end
    end

    class ParseIndividualNumber
      extend Forwardable
      def_delegators :parse_status, :reset=, :memory=, :answer=, :reset, :memory, :answer

      attr_reader :parse_status, :num

      def initialize(parse_status, num)
        @parse_status = parse_status
        @num = num
      end

      def call
        if reset
          clear
        else
          handle_power_of_ten

          update_memory
        end

        [reset, memory, answer]
      end

      private

      def clear
        self.reset = false
        self.memory += num
      end

      def handle_power_of_ten
        # x4. multiply memory by 10^9 because memory < power of ten
        return unless power_of_ten?(num)
        return unless power_of_ten(num) > 2

        self.memory *= num
        # 17. add memory to answer  (and reset) (memory pow of ten > 2)
        self.answer += memory
        self.memory = 0
        self.reset = true
      end

      def update_memory
        self.memory = new_memory
      end

      def new_memory
        if memory < num
          memory * num
        else
          memory + num
        end
      end

      def power_of_ten(integer)
        Math.log10(integer)
      end

      def power_of_ten?(integer)
        return true if integer.zero?

        power_of_ten(integer) == power_of_ten(integer).to_i
      end
    end

    # 15,16
    # 85,16
    def pair_parse(ints, only_compress = false)
      ints = compress(ints)
      return ints if only_compress
      return ints[0] if ints.length == 1

      sum = 0

      ints.each do |n|
        sum *= n >= 10 ? 100 : 10
        sum += n
      end

      sum
    end

    # [40, 2] => [42]
    def compress(ints)
      return [] if ints.empty?

      result = []
      index = 0

      index, result = compress_numbers(ints, result, index)

      result << ints[-1] if index < ints.length

      result
    end

    def compress_numbers(ints, result, index)
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
