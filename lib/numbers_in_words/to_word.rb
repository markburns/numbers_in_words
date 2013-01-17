class NumbersInWords::ToWord
  include NumbersInWords::Constants
  delegate :to_i, to: :that
  attr_reader :that

  def initialize that
    @that = that
  end

  def handle_exception
    EXCEPTIONS[@that] if @that.is_a?(Integer) and EXCEPTIONS[@that]
  end

  def in_words language="English"
    case language
    when "English" #allow for I18n
      in_english
    end
  end

  def in_english
    v = handle_exception
    return v if v

    writer = NumbersInWords::LanguageWriterEnglish.new(@that)

    in_decimals = writer.decimals
    return in_decimals if in_decimals

    number = to_i

    return writer.negative() if number < 0

    length = number.to_s.length
    output = ""

    if length == 2 #20-99
      tens = (number/10).round*10 #write the tens

      output << EXCEPTIONS[tens] # e.g. eighty

      digit = number - tens       #write the digits

      output << " " + digit.in_words unless digit==0
    else
      output << writer.write() #longer numbers
    end

    output.strip
  end
end
