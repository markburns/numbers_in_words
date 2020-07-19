# frozen_string_literal: true

module NumbersInWords
  RSpec.describe Fraction do
    subject do
      described_class.new(numerator: numerator, denominator: denominator, numerator: numerator, attributes: attributes)
    end

    let(:numerator) { 1 }

    context 'halves' do
      let(:denominator) { 2 }
      let(:attributes) do
        { number: 'two',
          ordinal: 'second',
          fraction: { singular: 'half', plural: 'halves' } }
      end

      it do
        expect(subject.in_words).to eq 'one half'
      end

      context 'with plural' do
        let(:numerator) { 2 }

        it do
          expect(subject.in_words).to eq 'two halves'
        end
      end
    end

    context 'quarters' do
      let(:denominator) { 4 }
      let(:attributes) do
        {
          number: 'four',
          ordinal: 'fourth',
          fraction: { singular: 'quarter' }
        }
      end

      it do
        expect(subject.in_words).to eq 'one quarter'
      end
    end

    context 'fifths' do
      let(:denominator) { 5 }
      let(:attributes) do
        { number: 'five', ordinal: 'fifth' }
      end

      it do
        expect(subject.in_words).to eq 'one fifth'
      end
    end

    context 'sixths' do
      let(:denominator) { 6 }
      let(:attributes) { {} }

      it do
        expect(subject.in_words).to eq 'one sixth'
      end
    end

    context 'nineteenths' do
      let(:denominator) { 19 }
      let(:attributes) { {} }

      it do
        expect(subject.in_words).to eq 'one nineteenth'
        expect(subject.fraction).to eq 'nineteenth'
      end

      context 'plural' do
        let(:numerator) { 763 }

        it do
          expect(subject.in_words).to eq 'seven hundred and sixty-three nineteenths'
        end
      end
    end

    context 'one hundred and seconds' do
      let(:denominator) { 102 }
      let(:attributes) { {} }

      it do
        expect(subject.in_words).to eq 'one one hundred and second'
      end
    end

    context 'one hundred and sixth' do
      let(:denominator) { 106 }
      let(:attributes) { {} }

      it do
        expect(subject.in_words).to eq 'one one hundred and sixth'
      end
    end

    context 'one hundred and nineteenth' do
      let(:denominator) { 119 }
      let(:attributes) { {} }

      it do
        expect(subject.ordinal).to eq 'one hundred and nineteenth'
        expect(subject.in_words).to eq 'one one hundred and nineteenth'
      end
    end

    context 'one thousandth' do
      let(:denominator) { 1000 }
      let(:attributes) { {} }

      it do
        expect(subject.ordinal).to eq 'one thousandth'
        expect(subject.in_words).to eq 'one one thousandth'
      end

      context 'plural' do
        let(:numerator) { 2 }
        let(:denominator) { 1000 }

        it do
          expect(subject.in_words).to eq 'two thousandths'
        end
      end
    end
  end
end
