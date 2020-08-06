# frozen_string_literal: true

require './spec/spec_helper'
require 'numbers_in_words/parsing/number_parser'

describe NumbersInWords::NumberParser do
  subject do
    super().parse(number)
  end

  context 'with single digit' do
    let(:number) { [9] }
    it { expect(subject).to eq 9 }
  end

  context 'with thousands' do
    let(:number) { [20, 1000] }
    it { expect(subject).to eq 20_000 }
  end

  context 'with thousands with a leading one' do
    let(:number) { [1, 1000, 6, 100] }
    it { expect(subject).to eq 1600 }
  end

  context 'with hundreds' do
    let(:number) { [2, 100, 45] }

    it { expect(subject).to eq 245 }
  end
end
