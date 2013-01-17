module NumbersInWords
  class NumberGroup
    include Enumerable
    attr_accessor :number

    def each
      @array.each { |item|  yield item}
    end

    def initialize number
      @number = number
    end

    #split into groups this gives us 1234567 => 123 456 7
    #so we need to reverse first
    #in stages
    def groups size
      #1234567   => %w(765 432 1)
      @array = @number.to_s.reverse.split("").in_groups_of(size)
      #%w(765 432 1) => %w(1 432 765)
      @array.reverse!

      #%w(1 432 765) => [1, 234, 567]
      @array.map! {|group| group.reverse.join("").to_i}
      @array.reverse! # put in ascending order of power of ten

      power = 0

      #[1, 234, 567] => {6 => 1, 3 => 234, 0 => 567}
      @array.inject({}) do |o, digits|
        o[power] = digits
        power += size
        o
      end
    end

    def split_decimals
      if @number.is_a? Float
        int, decimal = @number.to_s.split "."

        return int.to_i, decimal.split(//).map(&:to_i)
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
