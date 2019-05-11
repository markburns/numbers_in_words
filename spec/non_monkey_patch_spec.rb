require 'spec_helper'

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

  it do
    expect(NumbersInWords.ordinal(1)).to eq 'first'
    expect(NumbersInWords.ordinal(2)).to eq 'second'
    expect(NumbersInWords.ordinal(3)).to eq 'third'
    expect(NumbersInWords.ordinal(9)).to eq 'ninth'
    expect(NumbersInWords.ordinal(12)).to eq 'twelfth'
    expect(NumbersInWords.ordinal(21)).to eq 'twenty first'
    expect(NumbersInWords.ordinal(29)).to eq 'twenty ninth'
    expect(NumbersInWords.ordinal(32)).to eq 'thirty second'
    expect(NumbersInWords.ordinal(101)).to eq 'one hundred first'
    expect(NumbersInWords.ordinal(1001)).to eq 'one thousand first'
  end

  FRACTIONS = {
    [1, 2] => "half",
    [3, 2] => "three halves",
    [1, 3] => "third",
    [1, 4] => "quarter",
    [1, 5] => "fifth",
    [1, 19] => "nineteenth",
    [2, 17] => "two seventeenths",
    [1, 21] => "one twenty first",
    [1, 32] => "one thirty second",
    [1, 101] => "one one hundred first",
    [3, 101] => "three one hundred firsts",
    [73, 102] => "seventy three one hundred seconds",
    [13, 97] => "thirteen ninety sevenths",
  }

  FRACTIONS.each do  |(numerator, denominator), string|
    it "#{numerator}/#{denominator} == #{string}" do
      expect(NumbersInWords.in_words(numerator.to_f / denominator.to_f, fraction: true)).to eql(string)
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
