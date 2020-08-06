# frozen_string_literal: true

module NumbersInWords
  module NumericExtension
    def in_words(fraction: false)
      NumbersInWords::ToWord.new(self).in_words(fraction: fraction)
    end
  end

  module StringExtension
    def in_numbers(only_compress: false)
      NumbersInWords::ToNumber.new(self, only_compress).call
    end
  end
end

class String
  include NumbersInWords::StringExtension
end

class Numeric
  include NumbersInWords::NumericExtension
end
