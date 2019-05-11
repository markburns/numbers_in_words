require './spec/spec_helper'

describe NumbersInWords do
  FRACTIONS = {
    "half"   => 0.5,
    "a half" => 0.5,
    "one half" => 0.5,
    "two halves" => 1.0,
    "three halves" => 1.5,
  }

  FRACTIONS.each do  |string, float|
    pending do
      expect(string.in_numbers).to eql(float)
    end
  end
end
