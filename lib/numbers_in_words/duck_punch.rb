module NumbersInWords
  def in_words language=NumbersInWords.language
    NumbersInWords.in_words(self, language)
  end
end

module WordsInNumbers
  def in_numbers(only_compress = false, language=NumbersInWords.language)
    NumbersInWords::ToNumber.new(self, language).in_numbers(only_compress)
  end
end

class String
  include WordsInNumbers
end

class Numeric
  include NumbersInWords
end
