require './spec/spec_helper'

describe WordsInNumbers do
  it "should handle years notation" do
    expect("fifteen sixteen seventeen".in_numbers).to eq(151617)
    expect("forty nine ninety eight forty seven seventy nine".in_numbers).to eq(49984779)
     expect("sixty seven six".in_numbers) .to eq(676)
     expect("one fifty".in_numbers).to eq(150)
     expect("two fifty".in_numbers).to eq(250)
     expect("one point fifty six fifty seven".in_numbers).to eq(1.5657) 
     expect("one three forty seven".in_numbers).to eq(1347) 
     expect("one three five point forty seven".in_numbers).to eq(135.47)
		 expect("one ten sixty three".in_numbers).to eq(11063)
     expect("one nineteen ten oh five".in_numbers).to eq(1191005)
  end

end
