# frozen_string_literal: true

module NumbersInWords
  def in_words(language: NumbersInWords.language, fraction: false)
    NumbersInWords.in_words(self, language: language, fraction: fraction)
  end
end

module WordsInNumbers
  def in_numbers(only_compress: false, language: NumbersInWords.language)
    NumbersInWords::ToNumber.new(self, language: language).in_numbers(only_compress: only_compress)
  end
end

class String
  include WordsInNumbers
end

class Numeric
  include NumbersInWords
end
