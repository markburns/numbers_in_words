require './spec/spec_helper'

describe WordsInNumbers do
  it "should handle years notation" do
    "fifteen sixteen seventeen".num_compress .should == [15, 16, 17]
    "forty nine ninety eight forty seven seventy nine".num_compress .should == [49, 98, 47, 79]
     "sixty seven six".num_compress .should == [67, 6]
     "one fifty".num_compress.should == [1, 50]
     "two fifty".num_compress.should == [2, 50]
     "one three forty seven".num_compress.should == [1, 3, 47] 
  end

end
