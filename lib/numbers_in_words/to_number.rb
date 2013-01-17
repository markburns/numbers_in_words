class NumbersInWords::ToNumber
  delegate :to_s, to: :that
  attr_reader :that

  def initialize that
    @that = that
  end

  def in_numbers
    text = to_s

    NumbersInWords::WordToNumber.new.instance_eval do
      text = strip_punctuation text
      #negative numbers
      return -1 * (text.gsub(/^minus /, "")).in_numbers if text =~ /^minus /

      #easy single word case
      word = word_to_integer text
      return word if word

      #decimals
      match = text.match(/\spoint\s/)
      if match
        integer = match.pre_match.in_numbers

        decimal = decimal_portion match.post_match

        return integer + decimal
      end

      #multiple word case
      words = text.split " "
      integers = word_array_to_integers words

      integer = parse_numbers integers
      return integer if integer
      return nil
    end
  end
end
