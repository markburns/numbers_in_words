module WordsInNumbers

  DIGITS= %w[zero one two three four five six seven eight nine]

  EXCEPTIONS = {
  "ten"=>10,
  "eleven"=>11,
  "twelve"=>12,
  "thirteen"=>13,
  "fourteen"=>14,
  "fifteen"=>15,
  "sixteen"=>16,
  "seventeen"=>17,
  "eighteen"=>18,
  "nineteen"=>19,
  "twenty"=>20, 
  "thirty"=>30,
  "forty"=>40,
  "fifty"=>50,
  "sixty"=>60, 
  "seventy"=>70,
  "eighty"=>80,
  "ninety"=>90
  } 


  POWERS_OF_TEN ={
   "one"=>0, 
   "ten"=>   1 , 
   "hundred"=>   2, 
   "thousand"=>   3 , 
   "million"=>   6,
   "billion"=>   9, 
   "trillion"=>   12,
   "quadrillion"=>   15,
   "quintillion"=>   18, 
   "sextillion"=>   21,
   "septillion"=>   24, 
   "octillion"=>   27, 
   "nonillion"=>   30, 
   "decillion"=>   33,
   "undecillion"=>   36, 
   "duodecillion"=>   39,
   "tredecillion"=>   42, 
   "quattuordecillion"=>   45, 
   "quindecillion"=>   48,
   "sexdecillion"=>   51, 
   "septendecillion"=>   54,
   "octodecillion"=>   57, 
   "novemdecillion"=>   60, 
   "vigintillion"=>   63,
   "unvigintillion"=>   66, 
   "duovigintillion"=>   69, 
   "trevigintillion"=>   72,
   "quattuorvigintillion"=>   75,
   "quinvigintillion"=>   78, 
   "sexvigintillion"=>   81,
   "septenvigintillion"=>   84, 
   "octovigintillion"=>   87,
   "novemvigintillion"=>   90, 
   "trigintillion"=>   93,
   "untrigintillion"=>   96, 
   "duotrigintillion"=>   99,
   "googol"=>   100 
  }

  def strip_punctuation text
    #ignore punctuation
    text.downcase!
    text.gsub! /[^a-z ]/, " "
    to_remove = true
    until to_remove.nil?
      to_remove=text.gsub! "  ", " " until to_remove.nil?
    end
    return text
  end

  def decimal_portion text
    words = text.split " "
    integers = word_array_to_integers words
    decimal = "0." + integers.join()
    decimal.to_f
  end

  def in_numbers 
    text = self.to_s
    text = strip_punctuation text
    #negative numbers
    if text =~ /^minus /
      return -1 * (text.gsub(/^minus /, "")).in_numbers
    end

    #easy single word case
    word = word_to_integer(text)
    return word unless word.nil?

    #decimals
    match = text.match(/\spoint\s/)
    if match
      integer = match.pre_match
      integer = integer.in_numbers

      decimal = match.post_match
      decimal = decimal_portion(decimal)
      return integer + decimal
    end

    #multiple word case
    words = text.split " "
    integers = word_array_to_integers words

    integer= parse_numbers(integers)
    return integer unless integer.nil?
    return nil
  end


  # Example: 364,895,457,898
  #three hundred and sixty four billion eight hundred and ninety five million
  #four hundred and fifty seven thousand eight hundred and ninety eight
  #
  #3 100 60 4 10^9, 8 100 90 5 10^6, 4 100 50 7 1000, 8 100 90 8
  #                                                                    memory answer
  #x1. 3 add to memory because answer and memory are zero                 3     0
  #x2. memory * 100 (because memory<100)                                  300   0
  #x3. 60 add to memory because memory > 60                               360   0
  #x3. 4 add to memory because memory > 4                                364    0
  #x4. multiply memory by 10^9 because memory < power of ten          364*10^9  0
  #x5. add memory to answer  (and reset)memory > 8 (memory pow of ten > 2) 0   364*10^9
  #x6. 8 add to memory because not finished                                8    '' 
  #x7. multiply memory by 100 because memory < 100                        800   ''
  #x8. add 90 to memory because memory > 90                               890   ''
  #x9. add 5 to memory because memory > 5                                 895   ''
  #x10. multiply memory by 10^6 because memory < power of ten        895*10^6    ''
  #x11. add memory to answer (and reset) because memory power ten > 2       0    364895 * 10^6
  #x12. 4 add to memory because not finished                                4    ''
  #x13. memory * 100 because memory < 100                                 400    ''
  #x14. memory + 50 because memory > 50                                   450    ''
  #x15. memory + 7  because memory > 7                                    457    ''
  #x16. memory * 1000 because memory < 1000                            457000    ''
  #x17. add memory to answer  (and reset)memory > 8 (memory pow of ten > 2) 0   364895457000
  #x18. 8 add to memory because not finished                                8    ''
  #x19. memory * 100 because memory < 100                                 800    ''
  #x14. memory + 90 because memory > 90                                   890    ''
  #x15. memory + 8  because memory > 8                                    898    ''
  #16. finished so add memory to answer

  #Example 
  #2001
  #two thousand and one
  #2 1000 1
  #                                                                memory answer
  #1. add 2 to memory because first                                  2       0
  #2. multiply memory by 1000 because memory < 1000                2000      0
  #3. add memory to answer,reset,  because power of ten>2            0      2000
  #4. add 1 to memory                                                1      2000
  #5. finish - add memory to answer                                  0      2001
  def parse_numbers(integers)
    memory = 0
    answer = 0
    reset = true #reset each time memory is reset
    integers.each_with_index do |integer, index|
      if reset
        reset = false
        memory += integer
      else
        #x4. multiply memory by 10^9 because memory < power of ten  
        if is_power_of_ten?(integer)
          if power_of_ten(integer)> 2
            memory *= integer
            #17. add memory to answer  (and reset) (memory pow of ten > 2) 
            answer += memory
            memory = 0
            reset = true
          end
        end

        if memory < integer 
          memory *= integer
        else 
          memory += integer
        end
      end
    end
    answer += memory
  end

  def power_of_ten integer
    Math.log10(integer)
  end

  def is_power_of_ten? integer
    power_of_ten(integer)==power_of_ten(integer).to_i
  end

  #handles simple single word numbers
  #e.g. one, seven, twenty, eight, thousand etc
  def word_to_integer word
    text = word.to_s.chomp.strip
    #digits 0-9
    digit = DIGITS.index(text)
    return digit unless digit.nil? 

    #digits which are exceptions
    exception = EXCEPTIONS[text]
    return exception unless exception.nil?

    power = POWERS_OF_TEN[text]
    return 10**power unless power.nil?
    return nil
  end

  def word_array_to_integers words
    out = []
    words.map do |i|
      word = word_to_integer(i) 
      out << word unless word.nil?
    end
    return out
  end
end

class String
  include WordsInNumbers
end

