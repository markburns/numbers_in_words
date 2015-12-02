require './spec/spec_helper'

describe NumbersInWords do
  it "should recognize numerical strings" do
    arr = %w(8 56 100 5789 3435356)
    arr.each{ |s| expect(s.in_numbers).to eql(s.to_f) }
  end

  it "should recognize mixed strings" do
    mixed = {
      "19 hundred" => 1_900.0,
      "20 thousand" => 20_000.0,
      "100 million" => 100_000_000.0,
      "7 billion" => 7_000_000_000.0,
      "42 trillion" => 42_000_000_000_000.0
    }
    mixed.each{ |k, v| expect(k.in_numbers).to eql(v) }
  end
end
