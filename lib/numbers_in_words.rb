# frozen_string_literal: true

require 'numbers_in_words/version'
require 'numbers_in_words/to_word'
require 'numbers_in_words/exceptional_numbers'
require 'numbers_in_words/to_number'

module NumbersInWords
  LENGTH_OF_GOOGOL      = 101 # length of the string i.e. one with 100 zeros
  Error                 = ::Class.new(::StandardError)
  AmbiguousParsingError = ::Class.new(Error)
  DivideByZeroError     = ::Class.new(Error)
  InvalidNumber         = ::Class.new(Error)


  class << self
    extend Forwardable
    def_delegators :exceptional_numbers, :fraction

    def in_words(num, fraction: false)
      ToWord.new(num).in_words(fraction: fraction)
    end

    def in_numbers(words, only_compress: false)
      ToNumber.new(words).in_numbers(only_compress: only_compress)
    end

    def exceptional_numbers
      @exceptional_numbers ||= ExceptionalNumbers.new
    end

    def lookup(number)
      exceptional_numbers.lookup(number)
    end

    def exceptional_number(text)
      exceptional_numbers_to_i[text]
    end

    def power_of_ten(text)
      powers_of_ten_to_i[text]
    end

    private

    def exceptional_numbers_to_i
      @exceptional_numbers_to_i ||= swap_keys exceptional_numbers.to_h
    end

    def powers_of_ten_to_i
      @powers_of_ten_to_i ||= swap_keys ExceptionalNumbers::POWERS_OF_TEN
    end

    def swap_keys(hash)
      hash.each_with_object({}) { |(k, v), h| h[v] = k }
    end
  end
end
