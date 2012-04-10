require 'rubygems'
require 'active_support/core_ext/array'
module NumbersInWords
  EXCEPTIONS = {
    10 => "ten",
    11 => "eleven",
    12 => "twelve",

    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen" ,
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",

    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety"
  }

  DIGITS = %w[zero one two three four five six seven eight nine]

  POWERS_OF_TEN ={
    0   => "one",
    1   => "ten",
    2   => "hundred",
    3   => "thousand",
    6   => "million",
    9   => "billion",
    12  => "trillion",
    15  => "quadrillion",
    18  => "quintillion",
    21  => "sextillion",
    24  => "septillion",
    27  => "octillion",
    30  => "nonillion",
    33  => "decillion",
    36  => "undecillion",
    39  => "duodecillion",
    42  => "tredecillion",
    45  => "quattuordecillion",
    48  => "quindecillion",
    51  => "sexdecillion",
    54  => "septendecillion",
    57  => "octodecillion",
    60  => "novemdecillion",
    63  => "vigintillion",
    66  => "unvigintillion",
    69  => "duovigintillion",
    72  => "trevigintillion",
    75  => "quattuorvigintillion",
    78  => "quinvigintillion",
    81  => "sexvigintillion",
    84  => "septenvigintillion",
    87  => "octovigintillion",
    90  => "novemvigintillion",
    93  => "trigintillion",
    96  => "untrigintillion",
    99  => "duotrigintillion",
    100 => "googol"
    }

  LENGTH_OF_GOOGOL = 101 #length of the string i.e. one with 100 zeros

  def in_words language="English"
    case language
    when "English" #allow for I18n
      in_english
    end
  end

  def in_english
    #handle 0-9
    return DIGITS[self]     if self.is_a?(Integer) and (0..9).to_a.include? self
    #teens etc
    return EXCEPTIONS[self] if self.is_a?(Integer) and EXCEPTIONS[self]

    writer = LanguageWriterEnglish.new(self)

    in_decimals = writer.decimals
    return in_decimals unless in_decimals.nil?

    number = to_i

    return writer.negative() if number < 0

    length = number.to_s.length
    output = ""

    if length == 2 #20-99
      tens = (number/10).round*10 #write the tens

      output << EXCEPTIONS[tens] # e.g. eighty

      digit = number - tens       #write the digits

      output << " " + digit.in_english unless digit==0
    else
      output << writer.write() #longer numbers
    end

    output.strip
  end

  protected

  class LanguageWriter
    attr_accessor :number

    def initialize number
      @number = number
    end

    def group_words size
      #1000 and over Numbers are split into groups of three
      groups = NumberGroup.groups_of @number, size
      powers = groups.keys.sort.reverse #put in descending order

      powers.each do |power|
        name = POWERS_OF_TEN[power]
        digits = groups[power]
        yield power, name, digits
      end
    end
  end

  class LanguageWriterEnglish < LanguageWriter
    def negative
      "minus " + (-@number).in_english
    end

    def write
      length = @number.to_s.length
      output = if length == 3
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
        out = int.in_english + " point "
        decimals.each do |decimal|
          out << decimal.to_i.in_english + " "
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
        output << prefix + remainder.in_english
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
          output << prefix + digits.in_english
          output << prefix + name unless power == 0
        end
      end
      output
    end
  end

  class NumberGroup
    include Enumerable
    attr_accessor :number

    def each
      @array.each { |item|  yield item}
    end

    #split into groups this gives us 1234567 => 123 456 7
    #so we need to reverse first
    #in stages
    def initialize number
      @number = number
    end

    def groups size
      #i.e. 1234567 => 7654321
      groups = @number.to_s.reverse
      #7654321 => 765 432 1
      @array = groups.split("").in_groups_of(size)
      #765 432 1 => 1 432 765
      @array.reverse!
      #1 432 765 => 1 234 567
      #and turn back into integers
      @array.map! {|group| group.reverse.join("").to_i}
      @array.reverse! # put in ascending order of power of ten
      power = 0
      output = @array.inject({}) do |output, digits|
        output[power] = digits
        power += size
        output
      end
      output
    end

    def split_decimals
      if @number.is_a? Float
        int     = @number.to_i
        decimal = @number - int
        decimal = decimal.to_s.split(".")[1]
        digits  = decimal.split //
          #convert to integers array
          digits.inject([]) {|out, digit|
          out<< digit.to_i
        }
        return int, digits
      end
    end

    def self.groups_of number, size
      new(number).groups(size)
    end

    def split_googols
      output    = ""
      googols   = @number.to_s[0  ..  (-LENGTH_OF_GOOGOL)].to_i
      remainder = @number.to_s[(1-LENGTH_OF_GOOGOL) .. -1].to_i
      return googols, remainder
    end
  end
end


class Numeric
  include NumbersInWords
end
