class NumbersInWords::ToWord
  dir = './lib/numbers_in_words'

  SUPPORTED_LANGUAGES =
    Dir[dir + "/*"].
      select{|e| File.directory?(e) }.
      map{|x| x.gsub(/\A.*\//, '')}

  def initialize that, language=NumbersInWords.language
    @that = that
    @language = language
  end

  def in_words language=nil
    language ||= @language

    send "in_#{language.downcase}"
  end

  SUPPORTED_LANGUAGES.each do |lang|
    define_method "in_#{lang}" do
      lang = lang.capitalize
      klass = NumbersInWords.const_get(lang).const_get"LanguageWriter#{lang}"
      klass.new(@that).in_words
    end
  end
end
