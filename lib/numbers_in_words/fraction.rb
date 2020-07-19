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

    def ordinal_plural
      ordinal + 's'
    end

    def ordinal
      attributes[:ordinal] || number_in_words
    end

    def plural
      exception? && (fraction_plural || singular + 's') || ordinal_plural
    end

    def singular
      (exception? && exception[:singular]) || ordinal
    end

    private

    def number_in_words
      (attributes[:number] && attributes[:number] + 'th') || ordinal_in_words
    end

    def ordinal_in_words
      if number > 100
        rest = number % 100
        main = number - rest
        NumbersInWords.in_words(main) +
          ' and ' +
          NumbersInWords.fraction(number: rest).ordinal
      elsif number > 10
        rest = number % 10
        main = number - rest
        NumbersInWords.in_words(main) +
          '-' +
          NumbersInWords.fraction(number: rest).ordinal
      else
        NumbersInWords.in_words(number) + 'th'
      end
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
