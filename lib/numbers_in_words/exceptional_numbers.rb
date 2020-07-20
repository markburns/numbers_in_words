# frozen_string_literal: true

require 'forwardable'

require_relative 'fraction'

module NumbersInWords
  class ExceptionalNumbers
    extend Forwardable

    GOOGOL = 10 ** 100
    POWERS_OF_TEN = {
      0 => 'one',
      1 => 'ten',
      2 => 'hundred',
      1 * 3 => 'thousand',
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
      GOOGOL => 'googolplex'
    }.freeze

    POWERS_RX = Regexp.union(POWERS_OF_TEN.values[1..]).freeze

    DEFINITIONS = {
      0 => { number: 'zero', ordinal: 'zeroth'},
      1 => { number: 'one', ordinal: 'first' },
      2 => { number: 'two', ordinal: 'second', fraction:  { singular: 'half', plural: 'halves' } },
      3 => { number: 'three', ordinal: 'third' },
      4 => { number: 'four', ordinal: 'fourth', fraction: { singular: 'quarter', plural: 'quarters' } },
      5 => { number: 'five', ordinal: 'fifth' },
      6 => { number: 'six' },
      7 => { number: 'seven' },
      8 => { number: 'eight', ordinal: 'eighth' },
      9 => { number: 'nine', ordinal: 'ninth' },
      10 => { number: 'ten' },
      11 => { number: 'eleven' },
      12 => { number: 'twelve', ordinal: 'twelfth' },
      13 => { number: 'thirteen' },
      14 => { number: 'fourteen' },
      15 => { number: 'fifteen' },
      16 => { number: 'sixteen' },
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

    def fraction_names
      @fraction_names ||= determine_fraction_names
    end

    def lookup_fraction(words)
      fraction_lookup[words]
    end

    def fraction_lookup
      @fraction_lookup ||= generate_fraction_lookup
    end

    def lookup(number)
      to_h[number]
    end

    def fractions
      DEFINITIONS
    end

    def fraction(denominator: nil, numerator: nil, word: nil)
      raise unless denominator || word

      numerator ||= 1

      denominator ||= NumbersInWords.in_numbers(word)

      Fraction.new(denominator: denominator, numerator: numerator, attributes: DEFINITIONS[denominator])
    end

    def to_h
      @to_h ||= DEFINITIONS.transform_values do |h|
        h[:number]
      end
    end

    private

    def generate_fraction_lookup
      named_fractions.each_with_object({}) do |f, result|
        f.lookup_keys.each do |k|
          key = k.split(' ').last
          result[key] = 1.0 / f.denominator.to_f
        end
      end
    end

    def named_fractions
      @named_fractions ||= numbers.flat_map{|n|
        [
          Fraction.new(denominator: n, numerator: 1),
          Fraction.new(denominator: n, numerator: 2),
        ]
      }
    end

    def numbers
      (2..100).to_a + powers_of_ten_skipping_googolplex.map { |p| 10 ** p }
    end

    def powers_of_ten_skipping_googolplex
      POWERS_OF_TEN.keys[0..-2]
    end

    def determine_fraction_names
      names = named_fractions.map(&:in_words)

      words = names.map(&:split).map(&:last)
      words = words + strip_punctuation(words)
      words.uniq
    end

    def strip_punctuation(words)
      words.map {|w| w.gsub(/^a-z/, ' ')}
    end


  end
end
