# frozen_string_literal: true

require_relative 'writer'
require_relative 'number_group'
require_relative 'fraction'

module NumbersInWords
  # Arbitrarily small number for rationalizing fractions
  EPSILON = 0.0000000001

  class ToWord
    attr_reader :that

    def initialize(that)
      @that = that
    end

    def to_i
      that.to_i
    end

    def negative
      return unless to_i.negative?

      'minus ' + NumbersInWords.in_words(-@that)
    end

    def in_words(fraction: false)
      as_fraction(fraction) ||
        handle_exceptional_numbers ||
        decimals ||
        negative ||
        output
    end

    def as_fraction(fraction)
      return Fraction.in_words(that) if fraction
    end

    def decimals
      int, decimals = NumberGroup.new(@that).split_decimals
      return unless int

      out = NumbersInWords.in_words(int) + ' point '
      decimals.each do |decimal|
        out << NumbersInWords.in_words(decimal.to_i) + ' '
      end
      out.strip
    end

    def output
      output = if to_i.to_s.length == 2 # 20-99
                 handle_tens(to_i)
               else
                 Writer.new(that).call # longer numbers
               end

      output.strip
    end

    def handle_tens(number)
      output = ''

      tens = (number / 10).round * 10 # write the tens

      output += NumbersInWords.lookup(tens) # e.g. eighty

      digit = number - tens # write the digits

      unless digit.zero?
        join = number < 100 ? '-' : ' '
        output << join + NumbersInWords.in_words(digit)
      end

      output
    end

    def handle_exceptional_numbers
      return unless @that.is_a?(Integer)

      NumbersInWords.exceptional_numbers.lookup(@that)
    end
  end
end
