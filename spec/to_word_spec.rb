RSpec.describe NumbersInWords::ToWord do
  let(:number) { 2_111 }
  let(:writer) { described_class.new(number) }

  it 'should display numbers grouped' do
    count = 0

    writer.group_words(3) do |power, name, digits|
      case count
      when 0
        expect(power).to eq(3)
        expect(name).to eq('thousand')
        expect(digits).to eq(2)
      when 1
        expect(power).to eq(0)
        expect(name).to eq('one')
        expect(digits).to eq(111)
      end
      count += 1
    end

    expect(count).to eq 2
  end

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
