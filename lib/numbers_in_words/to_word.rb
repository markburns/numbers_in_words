class NumbersInWords::ToWord
  delegate :to_i, to: :that
  attr_reader :that

  def initialize that
    @that = that
  end

  def in_words language="English"
    case language
    when "English" #allow for I18n
      in_english
    end
  end

  def in_english
    NumbersInWords::LanguageWriterEnglish.new(@that).in_english
  end
end
