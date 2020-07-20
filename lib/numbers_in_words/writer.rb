# frozen_string_literal: true

module NumbersInWords
  class Writer
    def initialize(that)
      @that = that
    end

    def call
      length = @that.to_s.length
      output =
        if length == 3
          # e.g. 113 splits into "one hundred" and "thirteen"
          write_groups(2)

          # more than one hundred less than one googol
        elsif length < LENGTH_OF_GOOGOL
          write_groups(3)

        elsif length >= LENGTH_OF_GOOGOL
          write_googols
        end
      output.strip
    end

    def group_words(size)
      # 1000 and over Numbers are split into groups of three
      groups = NumberGroup.groups_of @that, size
      powers = groups.keys.sort.reverse # put in descending order

      powers.each do |power|
        name = NumbersInWords::POWERS_OF_TEN[power]
        digits = groups[power]
        yield power, name, digits
      end
    end

    private

    def write_googols
      googols, remainder = NumberGroup.new(@that).split_googols
      output = ''

      output = output + ' ' + NumbersInWords.in_words(googols) + ' googol'
      if remainder.positive?
        prefix = ' '
        prefix += 'and ' if remainder < 100
        output = output + prefix + NumbersInWords.in_words(remainder)
      end

      output
    end

    def write_groups(group)
      # e.g. 113 splits into "one hundred" and "thirteen"
      output = ''
      group_words(group) do |power, name, digits|
        if digits.positive?
          prefix = ' '
          # no and between thousands and hundreds
          prefix += 'and ' if power.zero? && (digits < 100)
          output = output + prefix + NumbersInWords.in_words(digits)
          output = output + prefix + name unless power.zero?
        end
      end
      output
    end
  end
end
