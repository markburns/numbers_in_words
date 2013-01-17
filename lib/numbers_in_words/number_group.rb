module NumbersInWords
  class NumberGroup
    include Enumerable
    LENGTH_OF_GOOGOL = 101 #length of the string i.e. one with 100 zeros
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
      #1234567   => 765 432 1
      @array = @number.to_s.reverse.split("").in_groups_of(size)
      @array.reverse!    #765 432 1 => 1 432 765

      #1 432 765 => 1 234 567
      @array.map! {|group| group.reverse.join("").to_i}
      @array.reverse! # put in ascending order of power of ten

      power = 0

      @array.inject({}) do |o, digits|
        o[power] = digits
        power += size
        o
      end
    end

    def split_decimals
      if @number.is_a? Float
        int     = @number.to_i
        decimal = @number - int
        decimal = decimal.to_s.split(".")[1]
        digits  = decimal.split(//)
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
      googols   = @number.to_s[0  ..  (-LENGTH_OF_GOOGOL)].to_i
      remainder = @number.to_s[(1-LENGTH_OF_GOOGOL) .. -1].to_i
      return googols, remainder
    end
  end
end
