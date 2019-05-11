
require './spec/spec_helper'

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

  context 'with fractions' do
    context 'with only denominator' do
      let(:number) { [0.5] }
      it { expect(subject).to eq 0.5 }
    end

    context 'with numerator denominator' do
      let(:number) { [1, 0.5] }
      it { expect(subject).to eq 0.5 }
    end

    context 'with multiple denominator' do
      let(:number) { [3, 0.5] }
      it { expect(subject).to eq 1.5 }
    end

    context 'with tens denominator' do
      let(:number) { [2, 3, 0.5] }
      pending { expect(subject).to eq 21.5 }
    end

    context 'with invalid number' do
      let(:number) { [2, 1, 0.5, 1] }
      it { expect{subject}.to raise_error NumbersInWords::InvalidNumber }
    end

    context 'with numerator and denominator' do
      let(:number) { [2, 0.5] }
      it { expect(subject).to eq 1.0 }
    end
  end

  context 'with hundreds' do
    let(:number) { [2, 100, 45] }

    it { expect(subject).to eq 245 }
  end
end


