class NumbersInWords::ToWord
  def initialize that, language=NumbersInWords.language
    @that = that
    @language = language
  end

  def in_words language=nil
    language ||= @language

    send "in_#{language.downcase}"
  end

  def in_english
    NumbersInWords::English::LanguageWriterEnglish.new(@that).in_words
  end

  def in_japanese
    NumbersInWords::Japanese::LanguageWriterJapanese.new(@that).in_words
  end

end
