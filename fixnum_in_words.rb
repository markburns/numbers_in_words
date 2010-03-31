class Fixnum
  #handle exceptions to normal numbers
  EXCEPTIONS = {11=>"eleven", 12 => "twelve", 13 => "thirteen", 
    14=>"fourteen", 15=>"fifteen", 16=>"sixteen" , 
    17=> "seventeen", 18=> "eighteen", 19=> "nineteen", 
    20 => "twenty", 30=>"thirty", 
    40=>"forty", 50=>"fifty", 60 => "sixty", 70=> "seventy", 80=>"eighty", 
    90 => "ninety"}

  POWERS_OF_TEN ={0=>"one", 1 => "ten", 2=> "hundred", 
    3 => "thousand", 6=>"million"}
  DIGITS= %w[zero one two three four five six seven eight nine]

  def in_words language="English"
    if language=="English" #allow for I18n
      i = self.to_i # make a copy
      #handle 0-10
      return DIGITS[i] if i < 10
      return EXCEPTIONS[i] if EXCEPTIONS[i]
    end

  end

end
