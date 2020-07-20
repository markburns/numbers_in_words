# frozen_string_literal: true

require 'forwardable'
require_relative 'parse_fractions'
require_relative 'parse_status'
require_relative 'parse_individual_number'
require_relative 'pair_parsing'

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
      fractions(nums) ||
        small_numbers(nums, only_compress) ||
        pair_parsing(nums, only_compress) ||
        parse_each(nums)
    end

    private

    def fractions(nums)
      ParseFractions.new(nums).call
    end

    # 7 0.066666666666667 => 0.46666666666666

    # 15 => 15
    def small_numbers(nums, only_compress)
      return unless nums.length < 2
      return nums if only_compress

      nums.empty? ? 0 : nums[0]
    end

    # 15 75 => 1,575
    def pair_parsing(nums, only_compress)
      return if (SCALES_N & nums).any?

      pair_parse(nums, only_compress)
    end

    def parse_each(nums)
      status = ParseStatus.new

      nums.each do |num|
        ParseIndividualNumber.new(status, num).call
      end

      status.calculate
    end

    def pair_parse(nums, only_compress)
      PairParsing.new(nums, only_compress).pair_parse
    end
  end
end
