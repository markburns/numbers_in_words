# frozen_string_literal: true

require_relative 'definitions'

module NumbersInWords
  class ExceptionalNumbers
    def defines?(number)
      to_h.key?(number)
    end

    def to_h
      Definitions::DEFINITIONS.transform_values do |h|
        h[:number]
      end
    end

    def lookup_fraction(text)
      result = Definitions::DEFINITIONS.find do |i, details|
        (i != 0) && predefined?(details, text) || ordinal_present?(details, text)
      end

      result ||= infer_fraction(text)

      1 / result.first.to_f if result
    end

    def fractions
      @fractions ||= Fractions.new.call
    end

    class Fractions
      def call
        Definitions::DEFINITIONS.map do |_n, attrs|
          Fraction.new(attrs).call
        end.flatten.compact
      end
    end

    class Fraction
      attr_reader :attributes

      def initialize(attributes)
        @attributes = attributes
      end

      def call
        [singular, plural, ordinal, ordinal_plural].reject { |f| f == false }
      end

      def ordinal_plural
        ordinal + 's'
      end

      def ordinal
        attributes[:ordinal] || (attributes[:number] + 'th')
      end

      def plural
        fraction? && (fraction_plural || singular + 's')
      end

      def fraction_plural
        fraction? && fraction[:plural]
      end

      def singular
        fraction? && fraction[:singular]
      end

      def fraction?
        fraction&.is_a?(Hash)
      end

      def fraction
        attributes[:fraction]
      end
    end

    def ordinal(number)
      row = Definitions::DEFINITIONS[number]
      return row[:ordinal] || (row[:number] + 'th') if row

      last_digit = number.digits.first
      if last_digit != 0
        first_part = number - last_digit
        NumbersInWords.in_words(first_part) + ' ' + ordinal(last_digit)
      else
        result = NumbersInWords.in_words(number)
        remove_leading_one(number, result) + 'th'
      end
    end

    def fraction(numerator: 1, denominator: 1)
      row = Definitions::DEFINITIONS[denominator]

      r = if row
            row[:fraction] || row[:ordinal] || (row[:number] + 'th')
          else
            fallback(numerator, denominator)
          end

      denominator_string = pluralize(r, numerator)
      numerator_string = NumbersInWords.in_words(numerator)

      denominator_string = remove_leading_one(denominator, denominator_string)
      result = numerator_string + ' ' + denominator_string
      remove_leading_one(numerator, result)
    end

    def fetch(number)
      Definitions::DEFINITIONS[number][:number]
    end

    private

    def predefined?(details, text)
      f = details[:fraction]
      return unless f

      f[:singular] == text ||
        f[:plural] == text ||
        f[:singular] == singularize(text)
    end

    def ordinal_present?(details, text)
      o = details[:ordinal]
      return unless o

      o == text || o == singularize(text)
    end

    def infer_fraction(text)
      denominator = text.gsub(/ths?$|rds?$|onds?$/, '')
      return [NumbersInWords.in_numbers(denominator)] if denominator
    end

    def singularize(text)
      text.gsub(/s$/, '')
    end

    def fallback(numerator, denominator)
      remove_leading_one(numerator, NumbersInWords.ordinal(denominator))
    end

    def remove_leading_one(_numerator, string)
      parts = string.split(' ')

      if parts.first == 'one' && parts.length == 2
        parts.last
      else
        string
      end
    end

    def pluralize(row, num)
      if row.is_a?(String)
        return num == 1 ? row : row + 's'
      end

      num == 1 ? row[:singular] : (row[:plural] || pluralize(row[:singular], num))
    end
  end
end
