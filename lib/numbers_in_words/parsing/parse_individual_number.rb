# frozen_string_literal: true

module NumbersInWords
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
end
