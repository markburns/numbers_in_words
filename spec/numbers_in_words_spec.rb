require 'lib/numbers_in_words'
describe Fixnum do
  it "should print the digits 0-9 correctly" do
    numbers = %w[zero one two three four five six seven eight nine ten]
    10.times do |i|
      puts i.in_words
      i.in_words.should==numbers[i]

    end
  end
  it "should print the digits 11-19 correctly" do
    words = %w[eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen]
    numbers = [11,12,13,14,15,16,17,18,19]
    numbers.each_with_index do |number, index|
      puts number.in_words
      number.in_words.should==words[index]

    end
  end

  it "should return a hash of powers of ten" do
    117.powers_of_ten.should == {0=>7,1=>1,2=>1}
    0.powers_of_ten.should == {}
    1.powers_of_ten.should == {0=>1}
    9.powers_of_ten.should == {0=>9}
    10.powers_of_ten.should == {1=>1}
    18.powers_of_ten.should == {1=>1,0=>8}
    123456.powers_of_ten.should == {0=>6,1=>5,2=>4,3=>3,4=>2,5=>1}
  end

  it "should handle negative numbers" do
    -1.in_words.should == "minus one"
    -9.in_words.should == "minus nine"
    -10.in_words.should == "minus ten"
    -15.in_words.should == "minus fifteen"
    -100.in_words.should == "minus one hundred"
    (-1*(10**100)).in_words.should == "minus one googol"
    -123456789.in_words.should == "minus one hundred and twenty three million four hundred and fifty six thousand seven hundred and eighty nine"
  end
  it "should handle decimals" do
    pending
    1.1.in_words.should == "one point one"
    1.2345678.in_words.should == "one point two three four five six seven eight"
    1000.2345678.in_words.should == "one thousand point two three four five six seven eight"
    12345.2345678.in_words.should == "twelve thousand three hundred and forty five point two three four five six seven eight"
  end
  it "should split into group of three digit numbers" do
    1.groups_of(3).should == {0=>1}
    12.groups_of(3).should == {0=>12}
    123.groups_of(3).should == {0=>123}
    1111.groups_of(3).should == {3=>1,0=>111}
    87654.groups_of(3).should == {3=>87,0=>654}
    1234567.groups_of(3).should == {6=>1,3=>234,0=>567}
    123456789101112.groups_of(3).should == {12=>123,9=>456,6=>789,3=>101,0=>112}
  end

  it "should display numbers grouped" do
    2111.group_words 3 do |power, name, digits|
      puts "10^#{power} #{name} #{ digits }" 
    end
  end

  it "should handle two digit numbers" do
    21.in_words.should == "twenty one"
  end
  it "should handle three digit numbers" do 
    113.in_words.should == "one hundred and thirteen"
    299.in_words.should == "two hundred and ninety nine"
    300.in_words.should == "three hundred"
    101.in_words.should == "one hundred and one"
  end

  it "should print out some random examples correctly" do
    2999.in_words.should == "two thousand nine hundred and ninety nine"
    99999.in_words.should == "ninety nine thousand nine hundred and ninety nine"
    999999.in_words.should == "nine hundred and ninety nine thousand nine hundred and ninety nine"
    123456.in_words.should == "one hundred and twenty three thousand four hundred and fifty six"
    17054.in_words.should == "seventeen thousand and fifty four"
    11004.in_words.should == "eleven thousand and four"
    470154.in_words.should == "four hundred and seventy thousand one hundred and fifty four"
    417155.in_words.should == "four hundred and seventeen thousand one hundred and fifty five"
    999999.in_words.should == "nine hundred and ninety nine thousand nine hundred and ninety nine"
    1000000.in_words.should == "one million"
    1000001.in_words.should == "one million and one"
    112.in_words.should == "one hundred and twelve"

  end

  it "should handle edge cases" do
    1000001.in_words.should == "one million and one"
    (10*10**12 + 10**6 +1).in_words.should == "ten trillion one million and one"
    (10**75).in_words.should == "one quattuorvigintillion"
    10001001.in_words.should == "ten million one thousand and one"
  end
  it "should handle a googol and larger" do
    n=10**100
    puts n.in_words
    (10**100 + 1).in_words.should == "one googol and one"
    (42*10**100 + 16777216).in_words.should == "forty two googol sixteen million seven hundred and seventy seven thousand two hundred and sixteen"
    (42* 10**100 * 10**100).in_words.should == "forty two googol googol"
  end

end

