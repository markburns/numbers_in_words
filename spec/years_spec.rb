require './spec/spec_helper'

describe WordsInNumbers do
  YEARS = {
    "fifteen sixteen seventeen"                        => 151617,
    "forty nine ninety eight forty seven seventy nine" => 49984779,
     "one fifty"                                       => 150,
     "two fifty"                                       => 250,
     "three fifty"                                     => 350,
     "one point fifty six fifty seven"                 => 1.5657,
     "one three forty seven"                           => 1347,
     "one three five point forty seven"                => 135.47,
     "one ten sixty three"                             => 11063,
     "one nineteen ten oh five"                        => 1191005,
  }

  AMBIGUOUS = {
    "sixty seven six" => [676, 6076]
  }

  AMBIGUOUS.each do  |k, v|
    pending do
      expect{k.in_numbers}.to raise_error(NumbersInWords::AmbiguousParsingError, v)
    end
  end

  YEARS.each do  |k, v|
    it do
      expect(k.in_numbers).to eql(v)
    end
  end
end
