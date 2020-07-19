# frozen_string_literal: true
require 'forwardable'

require_relative 'fraction'

module NumbersInWords
  class ExceptionalNumbers
    extend Forwardable

    DEFINITIONS = {
      0 => { number: 'zero', ordinal: 'zeroth', fraction: -> { DivideByZeroError } },
      1 => { number: 'one', ordinal: 'first' },
      2 => { number: 'two', ordinal: 'second', fraction: { singular: 'half', plural: 'halves' } },
      3 => { number: 'three', ordinal: 'third' },
      4 => { number: 'four', ordinal: 'fourth', fraction: { singular: 'quarter' } },
      5 => { number: 'five', ordinal: 'fifth' },
      6 => { number: 'six' },
      7 => { number: 'seven' },
      8 => { number: 'eight', ordinal: 'eighth' },
      9 => { number: 'nine', ordinal: 'ninth' },
      10 => { number: 'ten' },
      11 => { number: 'eleven' },
      12 => { number: 'twelve', ordinal: 'twelfth' },
      13 => { number: 'thirteen'  },
      14 => { number: 'fourteen'  },
      15 => { number: 'fifteen'  },
      16 => { number: 'sixteen'  },
      17 => { number: 'seventeen' },
      18 => { number: 'eighteen' },
      19 => { number: 'nineteen' },
      20 => { number: 'twenty', ordinal: 'twentieth' },
      30 => { number: 'thirty', ordinal: 'thirtieth' },
      40 => { number: 'forty', ordinal: 'fortieth' },
      50 => { number: 'fifty', ordinal: 'fiftieth' },
      60 => { number: 'sixty', ordinal: 'sixtieth' },
      70 => { number: 'seventy', ordinal: 'seventieth' },
      80 => { number: 'eighty', ordinal: 'eightieth' },
      90 => { number: 'ninety', ordinal: 'ninetieth' }
    }.freeze

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

    def lookup(number)
      to_h[number]
    end

    def fraction(number: nil, word: nil)
      raise unless number || word

      number ||= NumbersInWords.in_numbers(word)

      Fraction.new(number, DEFINITIONS[number])
    end

    def to_h
      @to_h ||= DEFINITIONS.transform_values do |h|
        h[:number]
      end
    end
  end
end
