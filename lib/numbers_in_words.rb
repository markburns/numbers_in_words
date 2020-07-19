# frozen_string_literal: true

require 'numbers_in_words/version'
require 'numbers_in_words/to_word'
require 'numbers_in_words/exceptional_numbers'

require 'numbers_in_words/number_group'
require 'numbers_in_words/number_parser'
require 'numbers_in_words/to_number'
require 'numbers_in_words/to_word'

module NumbersInWords
  LENGTH_OF_GOOGOL      = 101 # length of the string i.e. one with 100 zeros
  Error                 = ::Class.new(::StandardError)
  AmbiguousParsingError = ::Class.new(Error)
  DivideByZeroError     = ::Class.new(Error)
  InvalidNumber         = ::Class.new(Error)

  POWERS_OF_TEN = {
    0 => 'one',
    1 => 'ten',
    2 => 'hundred',
    3 => 'thousand',
    2 * 3 => 'million',
    3 * 3 => 'billion',
    4 * 3 => 'trillion',
    5 * 3 => 'quadrillion',
    6 * 3 => 'quintillion',
    7 * 3 => 'sextillion',
    8 * 3 => 'septillion',
    9 * 3 => 'octillion',
    10 * 3 => 'nonillion',
    11 * 3 => 'decillion',
    12 * 3 => 'undecillion',
    13 * 3 => 'duodecillion',
    14 * 3 => 'tredecillion',
    15 * 3 => 'quattuordecillion',
    16 * 3 => 'quindecillion',
    17 * 3 => 'sexdecillion',
    18 * 3 => 'septendecillion',
    19 * 3 => 'octodecillion',
    20 * 3 => 'novemdecillion',
    21 * 3 => 'vigintillion',
    22 * 3 => 'unvigintillion',
    23 * 3 => 'duovigintillion',
    24 * 3 => 'trevigintillion',
    25 * 3 => 'quattuorvigintillion',
    26 * 3 => 'quinvigintillion',
    27 * 3 => 'sexvigintillion',
    28 * 3 => 'septenvigintillion',
    29 * 3 => 'octovigintillion',
    30 * 3 => 'novemvigintillion',
    31 * 3 => 'trigintillion',
    32 * 3 => 'untrigintillion',
    33 * 3 => 'duotrigintillion',
    100 => 'googol',
    101 * 3 => 'centillion',
    10**100 => 'googolplex'
  }.freeze

  POWERS_RX = Regexp.union(POWERS_OF_TEN.values[1..]).freeze

  class << self
    def in_words(num, fraction: false)
      ToWord.new(num).in_words(fraction: fraction)
    end

    def in_numbers(words, only_compress: false)
      ToNumber.new(words).in_numbers(only_compress: only_compress)
    end

    def ordinal(words)
      ToWord.new(words).ordinal
    end

    def exceptional_numbers
      @exceptional_numbers ||= ExceptionalNumbers.new
    end

    def fraction(number: nil, word: nil)
      exceptional_numbers.fraction(number: number, word: word)
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
      @powers_of_ten_to_i ||= swap_keys POWERS_OF_TEN
    end

    def swap_keys(hash)
      hash.each_with_object({}) { |(k, v), h| h[v] = k }
    end
  end
end
