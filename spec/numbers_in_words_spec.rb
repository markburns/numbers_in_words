# frozen_string_literal: true

require './spec/spec_helper'

describe NumbersInWords do
  describe '.in_words' do
    it do
      expect(NumbersInWords.in_words(100)).to eq 'one hundred'
    end
  end

  describe '.in_numbers' do
    it do
      expect(NumbersInWords.in_numbers('one-hundred')).to eq 100
    end
  end

  it 'should print the digits 0-9 correctly' do
    numbers = %w[zero one two three four five six seven eight nine]

    10.times { |i| expect(i.in_words).to eq(numbers[i]) }
  end

  it 'should print the digits 11-19 correctly' do
    words = %w[eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen]
    numbers = [11, 12, 13, 14, 15, 16, 17, 18, 19]
    numbers.each_with_index do |number, index|
      expect(number.in_words).to eq(words[index])
    end
  end

  it 'should handle two digit numbers' do
    expect(21.in_words).to eq('twenty-one')
  end

  it 'should handle three digit numbers' do
    expect(113.in_words).to eq('one hundred and thirteen')
    expect(299.in_words).to eq('two hundred and ninety-nine')
    expect(300.in_words).to eq('three hundred')
    expect(101.in_words).to eq('one hundred and one')
  end

  it 'should print out some random examples correctly' do
    expect(2999.in_words).to eq('two thousand nine hundred and ninety-nine')
    expect(99_999.in_words).to eq('ninety-nine thousand nine hundred and ninety-nine')
    expect(999_999.in_words).to eq('nine hundred and ninety-nine thousand nine hundred and ninety-nine')
    expect(123_456.in_words).to eq('one hundred and twenty-three thousand four hundred and fifty-six')
    expect(24_056.in_words).to eq('twenty-four thousand and fifty-six')
    expect(17_054.in_words).to eq('seventeen thousand and fifty-four')
    expect(11_004.in_words).to eq('eleven thousand and four')
    expect(470_154.in_words).to eq('four hundred and seventy thousand one hundred and fifty-four')
    expect(417_155.in_words).to eq('four hundred and seventeen thousand one hundred and fifty-five')
    expect(999_999.in_words).to eq('nine hundred and ninety-nine thousand nine hundred and ninety-nine')
    expect(1_000_000.in_words).to eq('one million')
    expect(1_000_001.in_words).to eq('one million and one')
    expect(112.in_words).to eq('one hundred and twelve')
  end

  it 'should handle edge cases' do
    expect(1_000_001.in_words).to eq('one million and one')
    expect((10 * 10**12 + 10**6 + 1).in_words).to eq('ten trillion one million and one')
    expect((10**75).in_words).to eq('one quattuorvigintillion')
    expect(10_001_001.in_words).to eq('ten million one thousand and one')
  end

  it 'should handle a googol and larger' do
    n = 10**100
    expect((10**100 + 1).in_words).to eq('one googol and one')
    expect((42 * 10**100 + 16_777_216).in_words).to eq('forty-two googol sixteen million seven hundred and seventy-seven thousand two hundred and sixteen')
    expect((42 * 10**100 * 10**100).in_words).to eq('forty-two googol googol')
  end

  it 'should handle negative numbers' do
    expect(-1.in_words).to eq('minus one')
    expect(-9.in_words).to eq('minus nine')
    expect(-10.in_words).to eq('minus ten')
    expect(-15.in_words).to eq('minus fifteen')
    expect(-100.in_words).to eq('minus one hundred')
    expect((-1 * (10**100)).in_words).to eq('minus one googol')
    expect(-123_456_789.in_words).to eq('minus one hundred and twenty-three million four hundred and fifty-six thousand seven hundred and eighty-nine')
  end

  it 'should handle decimals' do
    # because of lack of absolute accuracy with floats
    # the output won't be exactly as you might expect
    # so we will match rather than find equivalents
    expect(1.1.in_words).to match(/one point one/)
    expect(1.2345678.in_words).to match(/one point two three four five six seven eight/)
    expect(1000.2345678.in_words).to match(/one thousand point two three four five six seven eight/)
    expect(12_345.2345678.in_words).to match(/twelve thousand three hundred and forty-five point two three four five six seven eight/)
    expect((10**9 + 0.1).in_words).to match(/one billion point one/)
  end
end
