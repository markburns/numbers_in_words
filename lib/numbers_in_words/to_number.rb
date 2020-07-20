# frozen_string_literal: true

require 'forwardable'
require_relative 'parsing/number_parser'

module NumbersInWords
  class ToNumber
    extend Forwardable
    def_delegator :that, :to_s

    attr_reader :that

    def initialize(that)
      @that = that
    end

    def in_numbers(only_compress: false)
      float ||
        negative(only_compress) ||
        fraction(text) ||
        mixed_words_and_digits(only_compress) ||
        one(only_compress) ||
        mixed ||
        decimal ||
        as_numbers(only_compress)
    end

    private

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

    def mixed_words_and_digits(only_compress)
      return unless numeric?(that)

      in_words = that.split(' ').map { |word| numeric?(word) ? NumbersInWords.in_words(word) : word }.join(' ')
      self.class.new(in_words).in_numbers(only_compress: only_compress)
    end

    def numeric?(word)
      word.match(/\d+/)
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

    def as_numbers(only_compress)
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

    def fraction(text)
      return unless possible_fraction?(text)

      NumbersInWords.exceptional_numbers.lookup_fraction(text)
    end

    def possible_fraction?(text)
      words = text.split(' ')
      result = words & NumbersInWords.exceptional_numbers.fraction_names
      result.length.positive?
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
        'oh' => 'zero'
      }
    end

    def check_mixed(txt)
      mixed = txt.match(/^(-?\d+(.\d+)?) (#{POWERS_RX}s?)$/)
      return unless mixed && mixed[1] && mixed[3]

      matches = [mixed[1], mixed[3]].map { |m| NumbersInWords.in_numbers m }
      matches.reduce(&:*)
    end

    def check_one(txt)
      txt.match(/^one (#{POWERS_RX})$/)
    end

    def strip_minus(txt)
      txt.gsub(/^minus/, '') if txt =~ /^minus/
    end

    def check_decimal(txt)
      txt.match(/\spoint\s/)
    end
  end
end
