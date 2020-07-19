# frozen_string_literal: true

require 'forwardable'
require_relative 'definitions'

module NumbersInWords
  class ExceptionalNumbers
    extend Forwardable
    def_delegators :to_h, :fetch

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
