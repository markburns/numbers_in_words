module NumbersInWords
  class LanguageWriterEnglish < LanguageWriter
    def negative
      "minus " + (-@number).in_words
    end

    def write
      length = @number.to_s.length
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
      int, decimals = NumberGroup.new(@number).split_decimals
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
      googols, remainder = NumberGroup.new(@number).split_googols
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
