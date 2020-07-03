# frozen_string_literal: true

module NumbersInWords
  module English
    class ExceptionalNumbers
      DEFINITIONS = {
        0 => { number: 'zero', ordinal: 'zeroth', fraction: -> { DivideByZeroError } },
        1 => { number: 'one', ordinal: 'first' },
        2 => { number: 'two', ordinal: 'second', fraction: { singular: 'half', plural: 'halves' } },
        3 => { number: 'three', ordinal: 'third' },
        4 => { number: 'four', ordinal: 'fourth', fraction: { singular: 'quarter' } },
        5 => { number: 'five', ordinal: 'fifth' },
        6 => { number: 'six' },
        7 => { number: 'seven' },
        8 => { number: 'eight', ordinal: 'eighth' },
        9 => { number: 'nine', ordinal: 'ninth' },
        10 => { number: 'ten' },
        11 => { number: 'eleven' },
        12 => { number: 'twelve', ordinal: 'twelfth' },
        13 => { number: 'thirteen'  },
        14 => { number: 'fourteen'  },
        15 => { number: 'fifteen'  },
        16 => { number: 'sixteen'  },
        17 => { number: 'seventeen' },
        18 => { number: 'eighteen' },
        19 => { number: 'nineteen' },
        20 => { number: 'twenty', ordinal: 'twentieth' },
        30 => { number: 'thirty', ordinal: 'thirtieth' },
        40 => { number: 'forty', ordinal: 'fortieth' },
        50 => { number: 'fifty', ordinal: 'fiftieth' },
        60 => { number: 'sixty', ordinal: 'sixtieth' },
        70 => { number: 'seventy', ordinal: 'seventieth' },
        80 => { number: 'eighty', ordinal: 'eightieth' },
        90 => { number: 'ninety', ordinal: 'ninetieth' }
      }.freeze

      def defines?(number)
        to_h.key?(number)
      end

      def to_h
        DEFINITIONS.each_with_object({}) do |(i, h), out|
          out[i] = h[:number]
        end
      end

      def lookup_fraction(text)
        result = DEFINITIONS.find do |i, details|
          (i != 0) && predefined?(details, text) || ordinal_present?(details, text)
        end

        result ||= infer_fraction(text)

        1 / result.first.to_f if result
      end

      def fractions
        DEFINITIONS.map do |_n, h|
          s = h[:fraction] && h[:fraction].is_a?(Hash) && h[:fraction][:singular]
          p = h[:fraction] && h[:fraction].is_a?(Hash) && (h[:fraction][:plural] || h[:fraction][:singular] + 's')
          o = h[:ordinal] || (h[:number] + 'th')
          op = o + 's'
          [s, p, o, op].reject { |f| f == false }
        end.flatten.compact
      end

      def ordinal(number)
        row = DEFINITIONS[number]
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
        row = DEFINITIONS[denominator]

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
        DEFINITIONS[number][:number]
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
end
