require './spec/spec_helper'

describe WordsInNumbers do
  it "should handle years notation" do
    "fifteen sixteen seventeen".in_numbers .should == 151617
    "forty nine ninety eight forty seven seventy nine".in_numbers .should == 49984779
     "sixty seven six".in_numbers .should == 676
     "one fifty".in_numbers.should == 150
     "two fifty".in_numbers.should == 250
     "one point fifty six fifty seven".in_numbers.should == 1.5657 
     "one three forty seven".in_numbers.should == 1347 
     "one three five point forty seven".in_numbers.should == 135.47 
  end

end
