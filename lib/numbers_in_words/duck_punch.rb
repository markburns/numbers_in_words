module NumbersInWords
  def in_words
    NumbersInWords::ToWord.new(self).in_words
  end
end

module WordsInNumbers
  def in_numbers
    NumbersInWords::ToNumber.new(self).in_numbers
  end
end

class String
  include WordsInNumbers
end

class Numeric
  include NumbersInWords
end
