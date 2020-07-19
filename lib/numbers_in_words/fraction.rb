# frozen_string_literal: true

module NumbersInWords
  class Fraction
    attr_reader :denominator, :numerator, :attributes

    def self.in_words(that)
      r = that.rationalize(EPSILON)

      NumbersInWords
        .fraction(denominator: r.denominator, numerator: r.numerator)
        .in_words
    end

    def initialize(denominator:, numerator: 1, attributes: nil)
      @denominator = denominator
      @numerator = numerator
      @attributes = attributes || NumbersInWords::ExceptionalNumbers::DEFINITIONS[denominator] || {}
    end

    def in_words
      NumbersInWords.in_words(numerator) + ' ' + fraction
    end

    def ordinal
      if pluralize?
        pluralized_ordinal || denominator_ordinal_in_words
      else
        singular_ordinal || denominator_ordinal_in_words
      end
    end

    def fraction
      if pluralize?
        fraction_plural || pluralized_ordinal || denominator_ordinal_in_words
      else
        fraction_singular || singular_ordinal || denominator_ordinal_in_words
      end
    end

    def plural
      exception? && (fraction_plural || singular + 's') || ordinal_plural
    end

    def singular
      (exception? && exception[:singular]) || ordinal
    end

    private

    def singular_ordinal
      attributes[:ordinal]
    end

    def pluralized_ordinal
      singular_ordinal && singular_ordinal + 's'
    end

    def pluralize?
      numerator > 1
    end

    def denominator_ordinal_in_words
      # one hundred and second
      if denominator > 100
        with_remainder(100, ' and ')
      elsif denominator > 19
        with_remainder(10, '-')
      else
        singular = NumbersInWords.in_words(denominator) + 'th'
        pluralize? ? singular + 's' : singular
      end
    end

    def with_remainder(mod, join_word)
      rest = denominator % mod
      main = denominator - rest
      main = NumbersInWords.in_words(main)

      main = main.gsub(/^one /, '') if pluralize?

      if rest.zero?
        if pluralize?
          return main + 'ths'
        else
          return main + 'th'
        end
      end

      main +
        join_word +
        self.class.new(numerator: numerator, denominator: rest).ordinal
    end

    def exception?
      exception&.is_a?(Hash)
    end

    def exception
      attributes[:fraction]
    end

    def fraction_singular
      exception? && exception[:singular]
    end

    def fraction_plural
      exception? && exception[:plural]
    end
  end
end
