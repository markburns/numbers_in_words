# frozen_string_literal: true

require './spec/spec_helper'

describe NumbersInWords::ExceptionalNumbers do
  describe '#fraction' do
    FRACTIONS = {
      [1, 2] => 'one half',
      [2, 2] => 'two halves',
      [3, 2] => 'three halves',
      [1, 3] => 'one third',
      [1, 4] => 'one quarter',
      [2, 17] => 'two seventeenths',
      [1, 1_000] => 'one one thousandth',
      [74, 101] => 'seventy-four hundred and firsts',
      [13, 97] => 'thirteen ninety-sevenths',
      [131, 1_000] => 'one hundred and thirty-one thousandths'
    }.freeze

    FRACTIONS.each do |(numerator, denominator), string|
      it "#{numerator}/#{denominator} == #{string}" do
        expect(subject.fraction(denominator: denominator, numerator: numerator).in_words).to eql(string)
      end
    end
  end
end
