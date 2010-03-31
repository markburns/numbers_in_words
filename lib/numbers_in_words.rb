require 'rubygems'
require 'active_support'
module NumbersToWords

  #handle exceptions to normal numbers
  EXCEPTIONS = {10=> "ten", 11=>"eleven", 12 => "twelve", 13 => "thirteen", 
    14=>"fourteen", 15=>"fifteen", 16=>"sixteen" , 
    17=> "seventeen", 18=> "eighteen", 19=> "nineteen", 
    20 => "twenty", 30=>"thirty", 
    40=>"forty", 50=>"fifty", 60 => "sixty", 70=> "seventy", 80=>"eighty", 
    90 => "ninety"}

  POWERS_OF_TEN ={0=>"one", 1 => "ten", 2=> "hundred", 
    3 => "thousand", 6=>"million", 9=>"billion", 12=>"trillion"}

  JAPANESE_POWERS_OF_TEN ={0=>"一", 1 => "十", 2=> "百", 
    3 => "千", 4=>"万",8=>"億", 12=>"兆"}
 
  DIGITS= %w[zero one two three four five six seven eight nine]
  JAPANESE_DIGITS= %w[〇 一 二 三 四 五 六 七 八 九]

  #returns a hash with powers of ten and their multipliers
  def powers_of_ten 
    i = self.to_i
    digits=i.to_s.split ""
    #turn back into integers
    digits.map! { |x| x.to_i} 
  
    digits.reverse!
    #create a hash where the key is the
    #power of ten and the value is the multipler
    power = 0
    return digits.inject({}) do |result,digit|
      result[power]=digit unless digit==0
      power+=1
      result
    end
  end

  def groups_of size
    i=self.to_i
    #split into groups this gives us 1234567 => 123 456 7
    #so we need to reverse first
    #in stages
    #i.e. 1234567 => 7654321     
    groups = i.to_s.reverse
    #7654321 => 765 432 1
    groups = groups.split("").in_groups_of(size)
    #765 432 1 => 1 432 765
    groups.reverse!
    #1 432 765 => 1 234 567
    groups.map! {|group| group.reverse}

    #turn back into integers
    groups.map! {|group|  group.join("").to_i }
    groups.reverse! # put in ascending order of power of ten
    
    #output hash where key is the power of ten
    #and value if the multiplier
    power = 0
    return groups.inject({}) do |output, digits|
      output[power]=digits
      power+=size
      output
    end

  end

  def group_words size, language="English"
    #1000 and over Numbers are split into groups of three
    number = self.to_i
    groups = number.groups_of(size)
    powers = groups.keys.sort.reverse #put in descending order
    powers.each do |power|
      name = POWERS_OF_TEN[power] if language=="English"
      name = JAPANESE_POWERS_OF_TEN[power] if language=="Japanese"
      digits = groups[power]
      yield power, name, digits
    end

  end

  def in_english
    number = self.to_i # make a copy
    #handle 0-10
    return DIGITS[number] if number < 10
    return EXCEPTIONS[number] if EXCEPTIONS[number]

    output = ""
    if number.to_s.length == 2 #20-99

      #write the tens
      tens = (number/10).round*10
      # e.g. eighty
      output << EXCEPTIONS[tens]

      #write the digits
      digit= number - tens
      output << " " + digit.in_english unless digit==0

    elsif number.to_s.length == 3
      #e.g. 113 splits into "one hundred" and "thirteen"
      number.group_words(2) do |power, name, digits|
        if digits > 0
          prefix = " "
          #no and between thousands and hundreds
          prefix << "and " if power == 0 
          output << prefix + digits.in_english
          output << prefix + name if power == 2 #add the hundred
        end
      end

    else #more than one hundred
      number.group_words 3 do |power, name, digits|
        if digits > 0
          prefix = " "
          prefix << "and " if power==0 and digits < 100
          output << prefix + digits.in_english
          output << " " + name  unless power==0
        end
      end
    end
    return output.strip
  end

  def in_japanese
    number = self.to_i # make a copy
    #handle 0-10
    return DIGITS[number] if number < 10
    return EXCEPTIONS[number] if EXCEPTIONS[number]

    output = ""
    if number.to_s.length == 2 #20-99

      #write the tens
      tens = (number/10).round
      # e.g. eighty
      output << JAPANESE_DIGITS[tens] << JAPANESE_POWERS_OF_TEN[1]
      digit= number - tens
      output << " " << JAPANESE_DIGITS[digit]
      #write the digits
    else #more than one hundred
      number.group_words 3 do |power, name, digits|
        if digits > 0
          prefix = " "
          prefix << "and " if power==0 and digits < 100
          output << prefix + digits.in_english
          output << " " + name  unless power==0
        end
      end
    end
    return output.strip
 
  end

  def in_words language="English"
    case language
    when "English" #allow for I18n
      in_english
    when "Japanese"
      in_japanese
    end
  end
end

class Fixnum
  include NumbersToWords
end
class Bignum

  include NumbersToWords
end
