# frozen_string_literal: true

require 'spec_helper'

describe 'NumbersInWords' do # rubocop: disable Metrics/BlockLength
  describe '.in_words' do
    it do
      expect(NumbersInWords.in_words(100)).to eq 'one hundred'
      expect(NumbersInWords.in_words(-100)).to eq 'minus one hundred'
      expect(NumbersInWords.in_words(24)).to eq 'twenty-four'
      expect(NumbersInWords.in_words(1.2)).to eq 'one point two'
      expect(NumbersInWords.in_words(100 * 10**100)).to eq 'one hundred googol'
      expect(NumbersInWords.in_words(30 + 100 * 10**100)).to eq 'one hundred googol and thirty'
    end
  end

  FRACTION_TO_WORDS = {
    [1, 2] => 'one half',
    [3, 2] => 'three halves',
    [1, 3] => 'one third',
    [1, 4] => 'one quarter',
    [1, 5] => 'one fifth',
    [1, 19] => 'one nineteenth',
    [2, 17] => 'two seventeenths',
    [1, 21] => 'one twenty-first',
    [1, 32] => 'one thirty-second',
    [1, 101] => 'one one hundred and first',
    [3, 101] => 'three hundred and firsts',
    [73, 102] => 'seventy-three hundred and seconds',
    [13, 97] => 'thirteen ninety-sevenths'
  }.freeze

  FRACTION_TO_WORDS.each do |(numerator, denominator), string|
    it "#{numerator}/#{denominator} == #{string}" do
      expect(NumbersInWords.in_words(numerator.to_f / denominator, fraction: true)).to eql(string)
    end
  end

  describe '.in_numbers' do
    it do
      expect(NumbersInWords.in_numbers('hundred')).to eq 100
      expect(NumbersInWords.in_numbers('one hundred')).to eq 100

      expect(NumbersInWords.in_numbers('minus one hundred')).to eq(-100)
      expect(NumbersInWords.in_numbers('twenty four')).to eq 24
      expect(NumbersInWords.in_numbers('one point two')).to eq 1.2
      expect(NumbersInWords.in_numbers('one hundred googol')).to eq 100 * 10**100
      expect(NumbersInWords.in_numbers('one hundred googol and thirty')).to eq 30 + 100 * 10**100
    end
  end
end
