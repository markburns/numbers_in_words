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

    def lookup_keys
      key = in_words
      key2 = strip_punctuation(key.split(' ')).join(' ')

      key3 = "a #{key}"
      key4 = "an #{key}"
      key5 = "a #{key2}"
      key6 = "an #{key2}"
      [key, key2, key3, key4, key5, key6].uniq
    end

    def in_words
      NumbersInWords.in_words(numerator) + ' ' + fraction
    end

    def ordinal
      pluralize? ? pluralized_ordinal_in_words : singular_ordinal_in_words
    end

    def fraction
      if denominator == Float::INFINITY
        # We've reached the limits of ruby's number system
        # by the time we get to a googolplex (10 ** (10 ** 100))
        return pluralize? ? 'infinitieths' : 'infinitieth'
      end

      pluralize? ? pluralized_fraction : singular_fraction
    end

    private

    def strip_punctuation(words)
      words.map { |w| w.gsub(/^a-z/, ' ') }
    end

    def pluralized_fraction
      fraction_plural || pluralized_ordinal_in_words
    end

    def singular_fraction
      fraction_singular || singular_ordinal_in_words
    end

    def pluralized_ordinal_in_words
      pluralized_ordinal || denominator_ordinal_in_words
    end

    def singular_ordinal_in_words
      singular_ordinal || denominator_ordinal_in_words
    end

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
      if denominator > 100
        # one hundred and second
        with_remainder(100, ' and ')
      elsif denominator > 19
        # two thirty-fifths
        with_remainder(10, '-')
      else
        # one seventh
        singular = NumbersInWords.in_words(denominator) + 'th'
        pluralize? ? singular + 's' : singular
      end
    end

    def with_remainder(mod, join_word)
      rest = denominator % mod
      main = denominator - rest
      main = NumbersInWords.in_words(main)

      main = main.gsub(/^one /, '') if pluralize?

      rest_zero(rest, main) || joined(main, rest, join_word)
    end

    def joined(main, rest, join_word)
      main +
        join_word +
        self.class.new(numerator: numerator, denominator: rest).ordinal
    end

    def rest_zero(rest, main)
      return unless rest.zero?

      if pluralize?
        main + 'ths'
      else
        main + 'th'
      end
    end

    def exception
      attributes[:fraction]
    end

    def fraction_singular
      exception && exception[:singular]
    end

    def fraction_plural
      exception && exception[:plural]
    end
  end
end
