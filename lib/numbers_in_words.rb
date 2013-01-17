require 'active_support/core_ext/array'

require "numbers_in_words/version"
require 'numbers_in_words/language_writer'

require 'numbers_in_words/english/constants'
require 'numbers_in_words/english/language_writer_english'

require 'numbers_in_words/number_group'
require 'numbers_in_words/number_parser'
require 'numbers_in_words/to_number'
require 'numbers_in_words/to_word'

module NumbersInWords
  LENGTH_OF_GOOGOL = 101 #length of the string i.e. one with 100 zeros

  class << self
    attr_writer :language
    def language
      @language ||= "English"
    end
  end
end

