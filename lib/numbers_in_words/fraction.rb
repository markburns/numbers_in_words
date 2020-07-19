module NumbersInWords
  class Fraction
    attr_reader :number, :attributes

    def self.in_words(that)
      r = that.rationalize(EPSILON)

      numerator = r.numerator
      numerator_in_words = ToWord.new(numerator).in_words

      meth = numerator == 1 ? :singular : :plural

      denominator = r.denominator
      denominator_in_words = NumbersInWords.fraction(number: denominator).public_send(meth)


      numerator_in_words + ' ' + denominator_in_words
    end


    def initialize(number, attributes)
      @number = number
      @attributes = attributes || {}
    end

    def call
      [singular, plural, ordinal, ordinal_plural].reject { |f| f == false }
    end

    def ordinal_plural
      ordinal + 's'
    end

    def ordinal
      attributes[:ordinal] || (number_in_words + 'th')
    end

    def plural
      exception? && (fraction_plural || singular + 's') || ordinal_plural
    end

    def singular
      (exception? && exception[:singular]) || ordinal
    end

    private

    def number_in_words
      attributes[:number] || NumbersInWords.in_words(number)
    end

    def exception?
      exception&.is_a?(Hash)
    end

    def exception
      attributes[:fraction]
    end

    def fraction_plural
      exception? && exception[:plural]
    end
  end
end
