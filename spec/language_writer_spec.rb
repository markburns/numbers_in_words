require './spec/spec_helper'

describe NumbersInWords::English::LanguageWriterEnglish do
  it "should display numbers grouped" do
    count = 0
    @writer = NumbersInWords::English::LanguageWriterEnglish.new(2111)
    @writer.group_words(3) do |power, name, digits|
      case count
      when 0
        expect(power).to eq(3)
        expect(name).to eq("thousand")
        expect(digits).to eq(2)
      when 1
        expect(power).to eq(0)
        expect(name).to eq("one")
        expect(digits).to eq(111)
      end
      count += 1
    end
  end
end


