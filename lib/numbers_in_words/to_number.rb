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

  def handle_negative text
    -1 * (text.gsub(/^minus /, "")).in_numbers if text =~ /^minus /
  end

  def in_numbers
    text = to_s

    text = strip_punctuation text
    i = handle_negative text
    return i if i

    h = handle_decimals text
    return h if h

    f = handle_fractions text
    return f if f
    integers = word_array_to_integers text.split(" ")

    NumbersInWords::NumberParser.parse integers
  end

  def strip_punctuation text
    text = text.downcase.gsub(/[^a-z ]/, " ")
    to_remove = true

    to_remove = text.gsub! "  ", " " while to_remove

    text
  end

  def handle_decimals text
    match = text.match(/\spoint\s/)
    if match
      integer = match.pre_match.in_numbers

      decimal = decimal_portion match.post_match

      integer + decimal
    end
  end

  def decimal_portion text
    words    = text.split " "
    integers = word_array_to_integers words
    decimal  = "0." + integers.join()
    decimal.to_f
  end

  def handle_fractions text
    if text.match(/(half|quarter|third)/) # we have a fraction
      match = text.match(/\sand\s/)
      if match # there's a whole number prefix
        integer = match.pre_match.in_numbers
        fraction = fraction_portion match.post_match
        integer + fraction
      else # the fraction stands alone
        fraction_portion text
      end
    end
  end

  def fraction_portion text
    words    = text.split " "
    words    = words.collect(&:singularize)
    integers = word_array_to_integers words
    integers.inject(:*) # multiply them all together
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

