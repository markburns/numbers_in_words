# frozen_string_literal: true

module NumbersInWords
  RSpec.describe Fraction do
    subject do
      described_class.new(number, attributes)
    end

    context 'halves' do
      let(:number) { 2 }
      let(:attributes) do
        { number: 'two',
          ordinal: 'second',
          fraction: { singular: 'half', plural: 'halves' } }
      end

      it do
        expect(subject.singular).to eq 'half'
        expect(subject.plural).to eq 'halves'
        expect(subject.ordinal).to eq 'second'
        expect(subject.ordinal_plural).to eq 'seconds'
      end
    end

    context 'quarters' do
      let(:number) { 4 }
      let(:attributes) do
        {
          number: 'four',
          ordinal: 'fourth',
          fraction: { singular: 'quarter' }
        }
      end

      it do
        expect(subject.singular).to eq 'quarter'
        expect(subject.plural).to eq 'quarters'
        expect(subject.ordinal).to eq 'fourth'
        expect(subject.ordinal_plural).to eq 'fourths'
      end
    end

    context 'fifths' do
      let(:number) { 5 }
      let(:attributes) do
          { number: 'five', ordinal: 'fifth' }
      end

      it do
        expect(subject.singular).to eq 'fifth'
        expect(subject.plural).to eq 'fifths'
        expect(subject.ordinal).to eq 'fifth'
        expect(subject.ordinal_plural).to eq 'fifths'
      end
    end

    context 'sixths' do
      let(:number) { 6 }
      let(:attributes) { {} }

      it do
        expect(subject.singular).to eq 'sixth'
        expect(subject.plural).to eq 'sixths'
        expect(subject.ordinal).to eq 'sixth'
        expect(subject.ordinal_plural).to eq 'sixths'
      end
    end

    context 'sixths' do
      let(:number) { 6 }
      let(:attributes) { {} }

      it do
        expect(subject.singular).to eq 'sixth'
        expect(subject.plural).to eq 'sixths'
        expect(subject.ordinal).to eq 'sixth'
        expect(subject.ordinal_plural).to eq 'sixths'
      end
    end

    context 'sixths' do
      let(:number) { 6 }
      let(:attributes) { {} }

      it do
        expect(subject.singular).to eq 'sixth'
        expect(subject.plural).to eq 'sixths'
        expect(subject.ordinal).to eq 'sixth'
        expect(subject.ordinal_plural).to eq 'sixths'
      end
    end

    context 'one hundred and seconds' do 
      let(:number) { 102 }
      let(:attributes) { {} }

      it do
        expect(subject.singular).to eq 'one hundred and second'
        expect(subject.plural).to eq 'one hundred and seconds'
        expect(subject.ordinal).to eq 'one hundred and second'
        expect(subject.ordinal_plural).to eq 'one hundred and seconds'
      end
    end
  end
end
