# frozen_string_literal: true

module NumbersInWords
  module FractionParsing
    def fraction(text)
      return unless possible_fraction?(text)

      NumbersInWords.exceptional_numbers.lookup_fraction(text)
    end

    def strip_punctuation(text)
      text = text.downcase.gsub(/[^a-z 0-9]/, ' ')
      to_remove = true

      to_remove = text.gsub! '  ', ' ' while to_remove

      text
    end

    def possible_fraction?(text)
      words = text.split(' ')
      result = words & NumbersInWords.exceptional_numbers.fraction_names
      result.length.positive?
    end

    def text_including_punctuation
      to_s.strip
    end

    def text
      strip_punctuation text_including_punctuation
    end
  end
end
