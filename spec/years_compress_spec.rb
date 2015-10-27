require './spec/spec_helper'

describe WordsInNumbers do
  it "should handle years notation" do
    expect("fifteen sixteen seventeen".num_compress) .to eq([15, 16, 17])
    expect("forty nine ninety eight forty seven seventy nine".num_compress) .to eq([49, 98, 47, 79])
    expect("sixty seven six".num_compress) .to eq([67, 6])
    expect("one fifty".num_compress).to eq([1, 50])
    expect("two fifty".num_compress).to eq([2, 50])
    expect("one three forty seven".num_compress).to eq([1, 3, 47])
    expect("one hundred".num_compress).to eq([100])
  end

end
