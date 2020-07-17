# frozen_string_literal: true

require './spec/spec_helper'

describe NumbersInWords::ExceptionalNumbers do
  describe '#fraction' do
    FRACTIONS = {
      [1, 2] => 'half',
      [2, 2] => 'two halves',
      [3, 2] => 'three halves',
      [1, 3] => 'third',
      [1, 4] => 'quarter',
      [2, 17] => 'two seventeenths',
      [1, 1_000] => 'thousandth',
      [74, 101] => 'seventy-four one hundred firsts',
      [13, 97] => 'thirteen ninety sevenths',
      [131, 1_000] => 'one hundred and thirty-one thousandths'
    }.freeze

    FRACTIONS.each do |(numerator, denominator), string|
      pending "#{numerator}/#{denominator} == #{string}" do
        expect(subject.fraction(numerator: numerator, denominator: denominator)).to eql(string)
      end
    end
  end

  ORDINALS = {
    2 => 'second',
    3 => 'third',
    4 => 'fourth',
    17 => 'seventeenth',
    1_000 => 'thousandth',
    101 => 'one hundred first',
    97 => 'ninety seventh'
  }.freeze

  ORDINALS.each do |number, string|
    pending "#{number} == #{string}" do
      expect(subject.ordinal(number)).to eql(string)
    end
  end
end
