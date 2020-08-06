# frozen_string_literal: true

require 'forwardable'

require_relative 'fraction'
require_relative 'powers_of_ten'

module NumbersInWords
  class ExceptionalNumbers
    extend Forwardable

    DEFINITIONS = {
      0 => { number: 'zero', ordinal: 'zeroth' },
      1 => { number: 'one', ordinal: 'first' },
      2 => { number: 'two', ordinal: 'second', fraction: { singular: 'half', plural: 'halves' } },
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
      @named_fractions ||= numbers.flat_map do |n|
        [
          Fraction.new(denominator: n, numerator: 1),
          Fraction.new(denominator: n, numerator: 2)
        ]
      end
    end

    def numbers
      (2..100).to_a + powers_of_ten_skipping_googolplex.map { |p| 10**p }
    end

    def powers_of_ten_skipping_googolplex
      POWERS_OF_TEN.keys[0..-2]
    end

    def determine_fraction_names
      names = named_fractions.map(&:in_words)

      words = names.map(&:split).map(&:last)
      words += strip_punctuation(words)
      words.uniq
    end

    def strip_punctuation(words)
      words.map { |w| w.gsub(/^a-z/, ' ') }
    end
  end
end
