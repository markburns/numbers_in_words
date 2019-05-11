require "forwardable"

class NumbersInWords::ToNumber
  extend Forwardable
  def_delegator :that, :to_s

  def_delegators :language,
   :powers_of_ten_to_i, :exceptional_numbers_to_i, :canonize,
    :check_mixed, :check_one, :strip_minus, :check_decimal

  attr_reader :that, :language

  def initialize(that, language=NumbersInWords.language)
    @that = that
    @language = language
  end

  def language
    if @language.is_a? Module
      @language
    else
      @language = NumbersInWords.const_get(@language)
    end
  end

  def handle_negative(text, only_compress)
    stripped = strip_minus text
    if stripped
      stripped_n = NumbersInWords.in_numbers(stripped, language, only_compress)
      only_compress ? stripped_n.map{ |k| k * -1 } : -1 * stripped_n
    end
  end

  def in_numbers(only_compress = false)
    text = to_s.strip
    return text.to_f if text =~ /^-?\d+(.\d+)?$/

    text = strip_punctuation text

    i = handle_negative(text, only_compress)
    return i if i

    mixed = check_mixed text
    return mixed if mixed

    one = check_one text
    if one
      res = NumbersInWords.in_numbers(one[1], language)
      return only_compress ? [res] : res
    end

    h = handle_decimals text
    return h if h

    integers = word_array_to_integers text.split(" ")

    NumbersInWords::NumberParser.parse integers, only_compress
  end

  def strip_punctuation(text)
    text = text.downcase.gsub(/[^a-z 0-9]/, " ")
    to_remove = true

    to_remove = text.gsub! "  ", " " while to_remove

    text
  end

  def handle_decimals(text)
    match = check_decimal text
    if match
      integer = NumbersInWords.in_numbers(match.pre_match)
      decimal = NumbersInWords.in_numbers(match.post_match)
      integer +=  "0.#{decimal}".to_f
    end
  end

  #handles simple single word numbers
  #e.g. one, seven, twenty, eight, thousand etc
  def word_to_integer(word)
    text = canonize(word.to_s.chomp.strip)

    exceptional_number = exceptional_numbers_to_i[text]
    return exceptional_number if exceptional_number

    power = powers_of_ten_to_i[text]
    return 10 ** power if power
  end

  def word_array_to_integers words
    words.map { |i| word_to_integer i }.compact
  end
end

