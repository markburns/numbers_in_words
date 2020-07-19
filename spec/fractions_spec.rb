# frozen_string_literal: true

describe NumbersInWords do
  FRACTIONS = {
    'half' => 0.5,
    'a half' => 0.5,
    'one half' => 0.5,
    'two halves' => 1.0,
    'three halves' => 1.5,
    'three quarters' => 0.75,
    'three fifths' => 3 / 5.0,
    'seven fifteenths' => 7 / 15.0
  }.freeze

  PENDING = {
    'twenty and three fifteenths' => 20 + 3 / 15.0,
    'three ninety-sevenths' => 3 / 97.0
  }.freeze

  FRACTIONS.each do |string, float|
    pending "#{string} == #{float}" do
      expect(string.in_numbers).to eql(float)
    end
  end
end
