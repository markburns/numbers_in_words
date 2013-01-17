module NumbersInWords
  class LanguageWriter
    attr_reader :that
    delegate :exceptions, :powers_of_ten, to: :language

    def initialize that
      @that = that
    end

    def language
      if @language.is_a? Module
        @language
      else
        @language = NumbersInWords.const_get(@language)
      end
    end


    def group_words size
      #1000 and over Numbers are split into groups of three
      groups = NumberGroup.groups_of @that, size
      powers = groups.keys.sort.reverse #put in descending order

      powers.each do |power|
        name = powers_of_ten[power]
        digits = groups[power]
        yield power, name, digits
      end
    end
  end
end
