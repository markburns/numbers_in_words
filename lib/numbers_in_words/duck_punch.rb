module NumbersInWords
  def in_words language=NumbersInWords.language
    NumbersInWords.in_words(self, language)
  end
end

module WordsInNumbers
  def in_numbers language=NumbersInWords.language
    NumbersInWords.in_numbers(self, language)
  end
end

class String
  include WordsInNumbers
end

class Numeric
  include NumbersInWords
end
