# frozen_string_literal: true

require './spec/spec_helper'

describe NumbersInWords::NumericExtension do
  YEARS = {
    'thirteen hundred' => 13_00,
    'twenty-two hundred' => 22_00,
    'twenty-two hundred and five' => 22_05,
    'fifteen sixteen seventeen' => 151_617,
    'forty-nine ninety-eight forty-seven seventy-nine' => 49_984_779,
    'one fifty' => 150,
    'two fifty' => 250,
    'three fifty' => 350,
    'one point fifty-six fifty-seven' => 1.5657,
    'one three forty-seven' => 1347,
    'one three five-point forty-seven' => 135.47,
    'one ten sixty-three' => 11_063,
    'one nineteen ten oh five' => 1_191_005
  }.freeze

  YEARS.each do |k, v|
    it do
      expect(k.in_numbers).to eql(v)
    end
  end
end
