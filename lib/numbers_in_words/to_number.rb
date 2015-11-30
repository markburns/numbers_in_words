class NumbersInWords::ToNumber
  delegate :to_s, to: :that
  delegate :powers_of_ten_to_i, :exceptions_to_i, to: :language
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
    if text =~ /^minus/
      stripped = text.gsub(/^minus/, "")
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

    mixed = text.match /^(-?\d+(.\d+)?) (hundred|thousand|million|billion|trillion)$/

    if mixed && mixed[1] && mixed[3]
      third_match = NumbersInWords.in_numbers(mixed[3])
      first_match = NumbersInWords.in_numbers(mixed[1])
      return first_match * third_match
    end

    one = text.match /^one (hundred|thousand|million|billion|trillion)$/

    if one
      first_match = NumbersInWords.in_numbers(one[1])
      return only_compress ? [first_match] : first_match
    end

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
    match = text.match(/\spoint\s/)
    if match
      integer = NumbersInWords.in_numbers(match.pre_match)
      decimal = NumbersInWords.in_numbers(match.post_match)
      integer +=  "0.#{decimal}".to_f
    end
  end

  #handles simple single word numbers
  #e.g. one, seven, twenty, eight, thousand etc
  def word_to_integer word
    text = word.to_s.chomp.strip

    exception = exceptions_to_i[text]
    return exception if exception

    power = powers_of_ten_to_i[text]
    return 10 ** power if power
  end

  def word_array_to_integers words
    words.map { |i| word_to_integer i }.compact
  end
end

