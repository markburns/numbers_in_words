# frozen_string_literal: true

module NumbersInWords
  class NumberGroup
    include Enumerable
    attr_accessor :number

    def self.groups_of(number, size)
      new(number).groups(size)
    end

    def initialize(number)
      @number = number
    end

    # split into groups this gives us 1234567 => 123 456 7
    # so we need to reverse first
    # in stages
    def groups(size)
      # 1234567   => %w(765 432 1)
      @array = in_groups_of(@number.to_s.reverse.split(''), size)
      # %w(765 432 1) => %w(1 432 765)
      @array.reverse!

      # %w(1 432 765) => [1, 234, 567]
      @array.map! { |group| group.reverse.join('').to_i }
      @array.reverse! # put in ascending order of power of ten

      power = 0

      # [1, 234, 567] => {6 => 1, 3 => 234, 0 => 567}
      @array.each_with_object({}) do |digits, o|
        o[power] = digits
        power += size
      end
    end

    def split_decimals
      return unless @number.is_a? Float

      int, decimal = @number.to_s.split '.'

      [int.to_i, decimal.split(//).map(&:to_i)]
    end

    def split_googols
      googols   = @number.to_s[0..-LENGTH_OF_GOOGOL].to_i
      remainder = @number.to_s[(1 - LENGTH_OF_GOOGOL)..-1].to_i
      [googols, remainder]
    end

    private

    def in_groups_of(array, number, fill_with = nil)
      # size % number gives how many extra we have;
      # subtracting from number gives how many to add;
      # modulo number ensures we don't add group of just fill.
      padding = (number - array.size % number) % number
      collection = array.dup.concat(Array.new(padding, fill_with))

      collection.each_slice(number).to_a
    end
  end
end
