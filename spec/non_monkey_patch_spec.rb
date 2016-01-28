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
  end

  describe ".in_numbers" do
    it do
      expect(NumbersInWords.in_numbers("one hundred")).to eq 100

      expect(NumbersInWords.in_numbers("minus one hundred")).to eq -100
      expect(NumbersInWords.in_numbers("twenty four" )).to eq 24
      expect(NumbersInWords.in_numbers("one point two")).to eq 1.2
      expect(NumbersInWords.in_numbers("one hundred googol")).to eq  100*10**100
      expect(NumbersInWords.in_numbers("one hundred googol and thirty")).to eq 30 + 100*10**100
    end
  end


end
