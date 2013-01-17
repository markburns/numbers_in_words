require './spec/spec_helper'

describe WordsInNumbers do
  it "should do the digits 0-10" do
    "zero"  .in_numbers.should == 0
    "one"   .in_numbers.should == 1
    "two"   .in_numbers.should == 2
    "three" .in_numbers.should == 3
    "four"  .in_numbers.should == 4
    "five"  .in_numbers.should == 5
    "six"   .in_numbers.should == 6
    "seven" .in_numbers.should == 7
    "eight" .in_numbers.should == 8
    "nine"  .in_numbers.should == 9
  end

  it "should handle numbers for which there is one word" do
    "ten"       .in_numbers.should == 10
    "eleven"    .in_numbers.should == 11
    "twelve"    .in_numbers.should == 12
    "thirteen"  .in_numbers.should == 13
    "fourteen"  .in_numbers.should == 14
    "fifteen"   .in_numbers.should == 15
    "sixteen"   .in_numbers.should == 16
    "seventeen" .in_numbers.should == 17
    "eighteen"  .in_numbers.should == 18
    "nineteen"  .in_numbers.should == 19
    "twenty"    .in_numbers.should == 20
  end

  it "should handle two word numbers up to 100" do
    "twenty one"   .in_numbers.should == 21
    "twenty two"   .in_numbers.should == 22
    "twenty three" .in_numbers.should == 23
    "twenty four"  .in_numbers.should == 24
    "twenty five"  .in_numbers.should == 25
    "twenty six"   .in_numbers.should == 26
    "twenty seven" .in_numbers.should == 27
    "twenty eight" .in_numbers.should == 28
    "seventy six"  .in_numbers.should == 76
    "ninety nine"  .in_numbers.should == 99
  end

  it "should handle hundreds" do
    "one hundred"                  .in_numbers.should == 100
    "two hundred"                  .in_numbers.should == 200
    "three hundred"                .in_numbers.should == 300
    "nine hundred"                 .in_numbers.should == 900
    "one hundred and seventy six"  .in_numbers.should == 176
    "one hundred and seventy nine" .in_numbers.should == 179
    "nine hundred and ninety nine" .in_numbers.should == 999
  end

  it "should handle unusual hundreds" do
    "eleven hundred"   .in_numbers.should == 1100
    "twelve hundred"   .in_numbers.should == 1200
    "thirteen hundred" .in_numbers.should == 1300
    "fifteen hundred"  .in_numbers.should == 1500
    "nineteen hundred" .in_numbers.should == 1900

  end
  it "should handle thousands" do
    "two thousand and one"                       .in_numbers .should ==  2001
    "one thousand"                               .in_numbers .should ==  1000
    "two thousand"                               .in_numbers .should ==  2000
    "three thousand"                             .in_numbers .should ==  3000
    "nine thousand"                              .in_numbers .should ==  9000
    "nine thousand two hundred"                  .in_numbers .should ==  9200
    "nine thousand two hundred and seven"        .in_numbers .should ==  9207
    "nine thousand two hundred and ninety seven" .in_numbers .should ==  9297
    end

    it "should handle larger numbers" do
    "one million"                                .in_numbers .should ==  1000000
    "two googol five billion and seventy six"    .in_numbers .should ==  (2*10**100 + 5*10**9 + 76)
    "thirty seven million"                       .in_numbers .should == 37 * 10**6
    "twenty six googol"                          .in_numbers .should == 26 * 10**100
    end

  it "should handle numbers in hundreds of thousands etc" do
    "nine hundred thousand"                                            .in_numbers .should == 900000
    "three hundred and fifty seven thousand"                           .in_numbers .should == 357000
    "five million three hundred and fifty seven thousand"              .in_numbers .should == 5357000
    "nine hundred and ninety nine trillion"                            .in_numbers .should == 999 * 10**12
    end
    it "should handle negative numbers" do
    "minus one"                                                        .in_numbers .should == -1
    "minus two googol"                                                 .in_numbers .should == -2 * 10**100
    "minus nine hundred and ninety nine trillion"                      .in_numbers .should == -999 * 10**12
    end

    it "should ignore punctuation and capitalisation" do
    "Minus one"                                                        .in_numbers .should == -1
    "FIVE Million, three hundred and fifty-seVen Thousand"             .in_numbers .should == 5357000
    "FIVE,,./';';';[] Million, three hundred and fifty-seVen Thousand" .in_numbers .should == 5357000

    end

  it "should handle decimal points" do
    "one point one"                        .in_numbers .should == 1.1

    "zero point seven six five three four" .in_numbers .should == 0.76534
    "one trillion point six"               .in_numbers .should == 10**12 + 0.6

    long_number = <<-NUMBER
    nine duotrigintillion seven hundred and seventy seven untrigintillion
    fifty nine trigintillion one hundred and sixty novemvigintillion
    eight hundred and six octovigintillion seven hundred and thirty six
    septenvigintillion four hundred and seventy one sexvigintillion
    nine hundred and seventy quinvigintillion six hundred and thirty two
    quattuorvigintillion eight hundred and twenty seven trevigintillion
    eight hundred and thirty six duovigintillion nine hundred and fifty
    two unvigintillion seven hundred and ten vigintillion eight hundred and one
    novemdecillion nine hundred and forty eight octodecillion seven hundred
    and five septendecillion six hundred and eighty three sexdecillion
    one hundred and six quindecillion seven hundred and seven quattuordecillion
    seven hundred and fifty seven tredecillion four hundred and twenty six
    duodecillion seven hundred and ninety five undecillion seven hundred
    and forty six decillion eight hundred and thirteen nonillion one hundred
    and twenty seven octillion four hundred and sixty five septillion two
    hundred and thirty seven sextillion one hundred and thirty nine
    quintillion one hundred and fifty three quadrillion forty six
    trillion seven hundred and fifty two billion eight hundred and three
    million ninety three thousand seven hundred and ninety one point
    eight nine five six four three two one eight nine five six seven eight
    NUMBER
    long_number.in_numbers.should ==
      9777059160806736471970632827836952710801948705683106707757426795746813127465237139153046752803093791.89564321895678

    "seventy five point eight four three two seven six nine four five one eight".
      in_numbers.should == 75.84327694518
  end

end
