class NumbersInWords::ToNumber
  delegate :to_s, to: :that
  delegate :powers_of_ten_to_i, :exceptions_to_i, :canonize, \
    :check_mixed, :check_one, :strip_minus, :check_decimal, to: :language
  attr_reader :that, :language

  def initialize that, language=NumbersInWords.language
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
      stripped_n = stripped.in_numbers(only_compress)
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
    return only_compress ? [one[1].in_numbers] : one[1].in_numbers if one

    h = handle_decimals text
    return h if h

    integers = word_array_to_integers text.split(" ")

    NumbersInWords::NumberParser.parse integers, only_compress
  end

  def strip_punctuation text
    text = text.downcase.gsub(/[^a-z 0-9]/, " ")
    to_remove = true

    to_remove = text.gsub! "  ", " " while to_remove

    text
  end

  def handle_decimals text
    match = check_decimal text
    if match
      integer = match.pre_match.in_numbers
      integer +=  ("0." + match.post_match.in_numbers.to_s).to_f
    end
  end

  #handles simple single word numbers
  #e.g. one, seven, twenty, eight, thousand etc
  def word_to_integer word
    text = canonize(word.to_s.chomp.strip)

    exception = exceptions_to_i[text]
    return exception if exception

    power = powers_of_ten_to_i[text]
    return 10 ** power if power
  end

  def word_array_to_integers words
    words.map { |i| word_to_integer i }.compact
  end
end

