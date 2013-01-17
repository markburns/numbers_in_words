require 'active_support/core_ext/array'

require "numbers_in_words/version"
require 'numbers_in_words/constants'
require 'numbers_in_words/language_writer'
require 'numbers_in_words/language_writer_english'
require 'numbers_in_words/number_group'
require 'numbers_in_words/word_to_number'
require 'numbers_in_words/to_number'
require 'numbers_in_words/to_word'

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

if NumbersInWords
  class String
    include WordsInNumbers
  end

  class Numeric
    include NumbersInWords
  end
end
