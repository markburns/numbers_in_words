RSpec.describe NumbersInWords::ToWord do
  let(:number) { 2_111 }
  let(:writer) { described_class.new(number) }

  describe '#in_words' do
    let(:number) { 99 }

    subject do
      writer.in_words
    end

    it do
      expect(subject).to eq 'ninety-nine'
    end
  end
end
