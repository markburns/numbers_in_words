# frozen_string_literal: true

require './spec/spec_helper'
require 'numbers_in_words/number_group'

describe NumbersInWords::NumberGroup do
  it 'should split into group of three digit numbers' do
    g = described_class
    expect(g.groups_of(1, 3)).to eq({ 0 => 1 })
    expect(g.groups_of(12, 3)).to eq({ 0 => 12 })
    expect(g.groups_of(123, 3)).to eq({ 0 => 123 })
    expect(g.groups_of(1111, 3)).to eq({ 3 => 1, 0 => 111 })
    expect(g.groups_of(87_654, 3)).to eq({ 3 => 87, 0 => 654 })
    expect(g.groups_of(1_234_567, 3)).to eq({ 6 => 1, 3 => 234, 0 => 567                    })
    expect(g.groups_of(123_456_789_101_112, 3)).to eq({ 12 => 123, 9 => 456, 6 => 789, 3 => 101, 0 => 112 })
  end
end
