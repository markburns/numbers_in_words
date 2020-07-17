# frozen_string_literal: true

require 'forwardable'
module NumbersInWords
  class ToNumber
    extend Forwardable
    def_delegator :that, :to_s

    def_delegators NumbersInWords,
                   :powers_of_ten_to_i, :exceptional_numbers_to_i, :canonize,
                   :check_mixed, :check_one, :strip_minus, :check_decimal

    attr_reader :that

    def initialize(that)
      @that = that
    end

    def in_numbers(only_compress: false)
      float || negative(only_compress) || one(only_compress) || mixed || decimal || integers(only_compress)
    end

    def float
      return text_including_punctuation.to_f if text =~ /^-?\d+(.\d+)?$/
    end

    def text_including_punctuation
      to_s.strip
    end

    def text
      strip_punctuation text_including_punctuation
    end

    def negative(only_compress)
      stripped = strip_minus text
      return unless stripped

      stripped_n = NumbersInWords.in_numbers(stripped, only_compress: only_compress)
      only_compress ? stripped_n.map { |k| k * -1 } : -1 * stripped_n
    end

    def strip_punctuation(text)
      text = text.downcase.gsub(/[^a-z 0-9]/, ' ')
      to_remove = true

      to_remove = text.gsub! '  ', ' ' while to_remove

      text
    end

    def one(only_compress)
      one = check_one text

      return unless one

      res = NumbersInWords.in_numbers(one[1])
      only_compress ? [res] : res
    end

    def mixed
      check_mixed text
    end

    def decimal
      match = check_decimal text
      return unless match

      integer = NumbersInWords.in_numbers(match.pre_match)
      decimal = NumbersInWords.in_numbers(match.post_match)
      integer + "0.#{decimal}".to_f
    end

    def integers(only_compress)
      integers = word_array_to_nums text.split(' ')

      NumbersInWords::NumberParser.new.parse integers, only_compress: only_compress
    end

    def word_array_to_nums(words)
      words.map { |i| word_to_num i }.compact
    end

    # handles simple single word numbers
    # e.g. one, seven, twenty, eight, thousand etc
    def word_to_num(word)
      text = canonize(word.to_s.chomp.strip)

      exceptional_number = exceptional_numbers_to_i[text]
      return exceptional_number if exceptional_number

      fraction = handle_fraction(text)
      return fraction if fraction

      power = powers_of_ten_to_i[text]
      return 10**power if power
    end
  end
end
