require './spec/spec_helper'

describe NumbersInWords::English::LanguageWriterEnglish do
  it "should display numbers grouped" do
    count = 0
    @writer = NumbersInWords::English::LanguageWriterEnglish.new(2111)
    @writer.group_words(3) do |power, name, digits|
      case count
      when 0
        power.should == 3
        name.should == "thousand"
        digits.should == 2
      when 1
        power.should == 0
        name.should == "one"
        digits.should == 111
      end
      count += 1
    end
  end
end


