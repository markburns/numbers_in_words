module NumbersInWords
  class LanguageWriter
    include NumbersInWords::Constants

    attr_accessor :that

    def initialize that
      @that = that
    end

    def group_words size
      #1000 and over Numbers are split into groups of three
      groups = NumberGroup.groups_of @that, size
      powers = groups.keys.sort.reverse #put in descending order

      powers.each do |power|
        name = POWERS_OF_TEN[power]
        digits = groups[power]
        yield power, name, digits
      end
    end
  end
end
