# frozen_string_literal: true

require './spec/spec_helper'

describe NumbersInWords do
  it 'recognizes numerical strings' do
    arr = %w[8 56 100 5789 3435356]
    arr.each { |s| expect(s.in_numbers).to eql(s.to_f) }
  end

  MIXED = {
    '19 hundred' => 1_900.0,
    '20 thousand' => 20_000.0,
    '100 million' => 100_000_000.0,
    '7 billion' => 7_000_000_000.0,
    '42 trillion' => 42_000_000_000_000.0
  }.freeze

  MIXED.each do |k, v|
    it do
      expect(k.in_numbers).to eql(v)
    end
  end

  PENDING = {
    '20 thousand and 4' => 20_004.0,
    '19 zero five' => 1_905.0
  }.freeze

  PENDING.each do |k, v|
    pending do
      expect(k.in_numbers).to eql(v)
    end
  end
end
