module NumbersInWords
  def in_words language=NumbersInWords.language
    NumbersInWords::ToWord.new(self, language).in_words
  end
end

module WordsInNumbers
  def in_numbers(only_compress = false, language=NumbersInWords.language)
    NumbersInWords::ToNumber.new(self, language).in_numbers(only_compress)
  end

  def num_compress language=NumbersInWords.language
    NumbersInWords::ToNumber.new(self, language).in_numbers true
  end
end

class String
  include WordsInNumbers
end

class Numeric
  include NumbersInWords
end
