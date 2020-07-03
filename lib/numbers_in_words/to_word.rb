# frozen_string_literal: true

class NumbersInWords::ToWord
  def initialize(that, language: NumbersInWords.language)
    @that = that
    @language = language
  end

  def in_words(language: nil, only_compress: false, fraction: false)
    language ||= @language

    case language
    when 'English' # allow for I18n
      in_english(fraction: fraction)
    end
  end

  def in_english(fraction: false)
    instance.in_words(fraction: fraction)
  end

  def ordinal
    instance.ordinal
  end

  private

  def instance
    NumbersInWords::English::LanguageWriterEnglish.new(@that)
  end
end
