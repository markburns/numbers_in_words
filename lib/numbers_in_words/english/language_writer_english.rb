module NumbersInWords
  # Arbitrarily small number for rationalizing fractions
  EPSILON = 0.0000000001

  module English
    class LanguageWriterEnglish < LanguageWriter
      def initialize that
        super that
        @language = "English"
      end

      def to_i
        that.to_i
      end

      def negative
        "minus " + NumbersInWords.in_words(-@that)
      end

      def ordinal
        exceptional_numbers.ordinal(@that)
      end

      def in_words(fraction: false)
        if fraction
          return in_fractions(that)
        end

        v = handle_exceptional_numbers
        return v if v

        in_decimals = decimals
        return in_decimals if in_decimals

        number = to_i

        return negative() if number < 0

        output = if number.to_s.length == 2 #20-99
                   handle_tens(number)
                 else
                   write() #longer numbers
                 end

        output.strip
      end

      def handle_tens(number)
        output = ""

        tens = (number/10).round*10 #write the tens

        output << exceptional_numbers.fetch(tens) # e.g. eighty

        digit = number - tens       #write the digits

        unless digit == 0
          output << " " + NumbersInWords.in_words(digit)
        end

        output
      end

      def handle_exceptional_numbers
        exceptional_numbers.fetch(@that) if @that.is_a?(Integer) && exceptional_numbers.defines?(@that)
      end


      def write
        length = @that.to_s.length
        output =
          if length == 3
            #e.g. 113 splits into "one hundred" and "thirteen"
            write_groups(2)

            #more than one hundred less than one googol
          elsif length < LENGTH_OF_GOOGOL
            write_groups(3)

          elsif length >= LENGTH_OF_GOOGOL
            write_googols
          end
        output.strip
      end

      def decimals
        int, decimals = NumberGroup.new(@that).split_decimals
        if int
          out = NumbersInWords.in_words(int) + " point "
          decimals.each do |decimal|
            out << NumbersInWords.in_words(decimal.to_i) + " "
          end
          out.strip
        end
      end

      private

      def in_fractions(number)
        r = that.rationalize(EPSILON)

        denominator = r.denominator
        numerator = r.numerator

        exceptional_numbers.fraction(denominator: denominator, numerator: numerator)
      end

      def write_googols
        googols, remainder = NumberGroup.new(@that).split_googols
        output = ""

        output << " " + NumbersInWords.in_words(googols) + " googol"
        if remainder > 0
          prefix = " "
          prefix << "and " if remainder < 100
          output << prefix + NumbersInWords.in_words(remainder)
        end

        output
      end

      def write_groups(group)
        #e.g. 113 splits into "one hundred" and "thirteen"
        output = ""
        group_words(group) do |power, name, digits|
          if digits > 0
            prefix = " "
            #no and between thousands and hundreds
            prefix << "and " if power == 0  and digits < 100
            output << prefix + NumbersInWords.in_words(digits)
            output << prefix + name unless power == 0
          end
        end
        output
      end
    end
  end
end
