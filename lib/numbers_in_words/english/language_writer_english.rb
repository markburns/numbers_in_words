module NumbersInWords
  module English
    class LanguageWriterEnglish < LanguageWriter
      delegate :to_i, to: :that

      def initialize that
        super that
        @language = "English"
      end

      def negative
        "minus " + (-@that).in_words
      end

      def in_words
        v = handle_exception
        return v if v

        in_decimals = decimals
        return in_decimals if in_decimals

        number = to_i

        return negative() if number < 0

        length = number.to_s.length
        output = ""

        if length == 2 #20-99
          tens = (number/10).round*10 #write the tens

          output << exceptions[tens] # e.g. eighty

          digit = number - tens       #write the digits

          output << " " + digit.in_words unless digit==0
        else
          output << write() #longer numbers
        end

        output.strip

      end

      def handle_exception
        exceptions[@that] if @that.is_a?(Integer) and exceptions[@that]
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
          out = int.in_words + " point "
          decimals.each do |decimal|
            out << decimal.to_i.in_words + " "
          end
          out.strip
        end
      end

      private
      def write_googols
        googols, remainder = NumberGroup.new(@that).split_googols
        output = ""
        output << " " + googols.in_words + " googol"
        if remainder > 0
          prefix = " "
          prefix << "and " if remainder < 100
          output << prefix + remainder.in_words
        end
        output
      end

      def write_groups group
        #e.g. 113 splits into "one hundred" and "thirteen"
        output = ""
        group_words(group) do |power, name, digits|
          if digits > 0
            prefix = " "
            #no and between thousands and hundreds
            prefix << "and " if power == 0  and digits < 100
            output << prefix + digits.in_words
            output << prefix + name unless power == 0
          end
        end
        output
      end
    end
  end
end
