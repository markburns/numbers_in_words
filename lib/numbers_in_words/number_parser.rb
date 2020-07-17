# frozen_string_literal: true

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
      fraction = nums.any? { |n| n < 1.0 && n != 0.0 }

      if fraction
        fraction_indicators = nums.map { |n| n < 1.0 }
        last_is_fraction, *numbers_are_fractions = fraction_indicators.reverse
        raise NumbersInWords::InvalidNumber if numbers_are_fractions.any? || !last_is_fraction

        case nums.length
        when 1
          return parse_nums(nums)
        when 2
          multiplier, fraction = nums
          return Rational(multiplier, 1 / fraction.to_f).rationalize(NumbersInWords::EPSILON).to_f
        else
          return parse_nums(nums[0..-3] + [0]) + parse_nums(nums[-2..])
        end
      end

      if nums.length < 2
        return nums if only_compress

        return nums.empty? ? 0 : nums[0]
      end

      return pair_parse(nums, only_compress) if (SCALES_N & nums).empty?

      parse_nums(nums)
    end

    def parse_fractions(fractions)
      floats = fractions.map(&:to_r).map { |r| [r.numerator, r.denominator] }.flatten.map(&:to_f)

      parse_nums(floats, addition_operator: :-, multiplication_operator: :/)
    end

    def parse_nums(nums, addition_operator: :+, multiplication_operator: :*)
      memory = 0
      answer = 0
      reset = true # reset each time memory is reset
      nums.each do |num|
        if reset
          reset = false
          memory = memory.send(addition_operator, num)
        else
          # x4. multiply memory by 10^9 because memory < power of ten
          if power_of_ten?(num)
            if power_of_ten(num) > 2
              memory = memory.send(multiplication_operator, num)
              # 17. add memory to answer  (and reset) (memory pow of ten > 2)
              answer = answer.send(addition_operator, memory)
              memory = 0
              reset = true
            end
          end
          memory = if memory < num
                     memory.send(multiplication_operator, num)
                   else
                     memory.send(addition_operator, num)
                   end
        end
      end

      answer.send(addition_operator, memory)
    end

    def power_of_ten(integer)
      Math.log10(integer)
    end

    def power_of_ten?(integer)
      return true if integer.zero?

      power_of_ten(integer) == power_of_ten(integer).to_i
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
      res = []
      i = 0
      return [] if ints.empty?

      while i < ints.length - 1
        int, jump = compress_int(ints[i], ints[i + 1])
        res << int
        i += jump
      end
      if i < ints.length
        res << ints[-1]
      else
        res
      end
    end

    def compress_int(int, sequel)
      tens = int % 10 == 0 && int > 10
      if tens && sequel < 10
        return [int + sequel, 2]
      else
        return [int, 1]
      end

      [res, jump]
    end
  end
end
