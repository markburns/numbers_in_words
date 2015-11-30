require 'numbers_in_words'

describe "NumbersInWords" do
  describe ".in_words" do
    it do
      expect(NumbersInWords.in_words(100)).to eq "one hundred"
      expect(NumbersInWords.in_words(-100)).to eq "minus one hundred"
      expect(NumbersInWords.in_words(24)).to eq "twenty four"
      expect(NumbersInWords.in_words(1.2)).to eq "one point two"
      expect(NumbersInWords.in_words(100*10**100)).to eq "one hundred googol"
      expect(NumbersInWords.in_words(30 + 100*10**100)).to eq "one hundred googol and thirty"
    end

    pending "This should be implemented" do
      expect(NumbersInWords.in_words(100*10**100)).to eq "one hundred googols"
    end
  end

  describe ".in_numbers" do
    it do
      expect(NumbersInWords.in_numbers("one hundred")).to eq 100
    end
  end


end
