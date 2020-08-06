# frozen_string_literal: true

require_relative './special'
require_relative './fraction_parsing'

module NumbersInWords
  class ToNumber
    include FractionParsing
    extend Forwardable
    def_delegator :that, :to_s

    attr_reader :that, :only_compress

    def initialize(that, only_compress)
      @that = that
      @only_compress = only_compress
    end

    def call
      special || decimal || as_numbers
    end

    private

    def special
      Special.new(that, only_compress).call
    end

    def decimal
      match = check_decimal text
      return unless match

      integer = NumbersInWords.in_numbers(match.pre_match)
      decimal = NumbersInWords.in_numbers(match.post_match)
      integer + "0.#{decimal}".to_f
    end

    def as_numbers
      numbers = word_array_to_nums text.split(' ')

      NumbersInWords::NumberParser.new.parse numbers, only_compress: only_compress
    end

    def word_array_to_nums(words)
      words.map { |i| word_to_num(i) }.compact
    end

    # handles simple single word numbers
    # e.g. one, seven, twenty, eight, thousand etc
    def word_to_num(word)
      text = canonize(word.to_s.chomp.strip)

      NumbersInWords.exceptional_number(text) || fraction(text) || power(text)
    end

    def power(text)
      power = NumbersInWords.power_of_ten(text)

      10**power if power
    end

    def canonize(word)
      aliases[word] || word
    end

    def aliases
      {
        'a' => 'one',
        'oh' => 'zero'
      }
    end

    def check_decimal(txt)
      txt.match(/\spoint\s/)
    end
  end
end
