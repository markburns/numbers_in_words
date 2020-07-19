# frozen_string_literal: true

module NumbersInWords
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
end
