# frozen_string_literal: true

require './spec/spec_helper'

describe WordsInNumbers do
  it 'should do the digits 0-10' do
    expect('zero'.in_numbers).to eq(0)
    expect('one'.in_numbers).to eq(1)
    expect('two'.in_numbers).to eq(2)
    expect('three'.in_numbers).to eq(3)
    expect('four'.in_numbers).to eq(4)
    expect('five'.in_numbers).to eq(5)
    expect('six'.in_numbers).to eq(6)
    expect('seven'.in_numbers).to eq(7)
    expect('eight'.in_numbers).to eq(8)
    expect('nine'.in_numbers).to eq(9)
  end

  it 'should handle numbers for which there is one word' do
    expect('ten'.in_numbers).to eq(10)
    expect('eleven'.in_numbers).to eq(11)
    expect('twelve'.in_numbers).to eq(12)
    expect('thirteen'.in_numbers).to eq(13)
    expect('fourteen'.in_numbers).to eq(14)
    expect('fifteen'.in_numbers).to eq(15)
    expect('sixteen'.in_numbers).to eq(16)
    expect('seventeen'.in_numbers).to eq(17)
    expect('eighteen'.in_numbers).to eq(18)
    expect('nineteen'.in_numbers).to eq(19)
    expect('twenty'.in_numbers).to eq(20)
  end

  it 'should handle two word numbers up to 100' do
    expect('twenty-one'.in_numbers).to eq(21)
    expect('twenty-two'.in_numbers).to eq(22)
    expect('twenty-three'.in_numbers).to eq(23)
    expect('twenty-four'.in_numbers).to eq(24)
    expect('twenty-five'.in_numbers).to eq(25)
    expect('twenty-six'.in_numbers).to eq(26)
    expect('twenty-seven'.in_numbers).to eq(27)
    expect('twenty-eight'.in_numbers).to eq(28)
    expect('seventy-six'.in_numbers).to eq(76)
    expect('ninety-nine'.in_numbers).to eq(99)
  end

  it 'should handle hundreds' do
    expect('one hundred'.in_numbers).to eq(100)
    expect('two hundred'.in_numbers).to eq(200)
    expect('three hundred'.in_numbers).to eq(300)
    expect('nine hundred'.in_numbers).to eq(900)
    expect('one hundred and seventy six'.in_numbers).to eq(176)
    expect('one hundred and seventy nine'.in_numbers).to eq(179)
    expect('nine hundred and ninety nine'.in_numbers).to eq(999)
  end

  it 'should handle unusual hundreds' do
    expect('eleven hundred'.in_numbers).to eq(1100)
    expect('twelve hundred'.in_numbers).to eq(1200)
    expect('thirteen hundred'.in_numbers).to eq(1300)
    expect('fifteen hundred'.in_numbers).to eq(1500)
    expect('nineteen hundred'.in_numbers).to eq(1900)
  end
  it 'should handle thousands' do
    expect('two thousand and one'.in_numbers).to eq(2001)
    expect('one thousand'.in_numbers).to eq(1000)
    expect('two thousand'.in_numbers).to eq(2000)
    expect('three thousand'.in_numbers).to eq(3000)
    expect('nine thousand'.in_numbers).to eq(9000)
    expect('nine thousand two hundred'.in_numbers).to eq(9200)
    expect('nine thousand two hundred and seven'.in_numbers).to eq(9207)
    expect('nine thousand two hundred and ninety seven'.in_numbers).to eq(9297)
  end

  it 'handles numbers that begin with a instead of one', :aggregate_failures do
    expect('a thousand six hundred'.in_numbers).to eq(1600)
    expect('a thousand six hundred and fifty-five'.in_numbers).to eq(1655)
  end

  it 'should handle larger numbers' do
    expect('one million'.in_numbers).to eq(1_000_000)
    expect('two googol five billion and seventy six'.in_numbers).to eq(2 * 10**100 + 5 * 10**9 + 76)
    expect('thirty seven million'.in_numbers).to eq(37 * 10**6)
    expect('twenty six googol'.in_numbers).to eq(26 * 10**100)
  end

  it 'should handle numbers in hundreds of thousands etc' do
    expect('nine hundred thousand'.in_numbers).to eq(900_000)
    expect('three hundred and fifty seven thousand'.in_numbers).to eq(357_000)
    expect('five million three hundred and fifty seven thousand'.in_numbers).to eq(5_357_000)
    expect('nine hundred and ninety nine trillion'.in_numbers).to eq(999 * 10**12)
  end
  it 'should handle negative numbers' do
    expect('minus one'.in_numbers).to eq(-1)
    expect('minus two googol'.in_numbers).to eq(-2 * 10**100)
    expect('minus nine hundred and ninety nine trillion'.in_numbers).to eq(-999 * 10**12)
  end

  it 'should ignore punctuation and capitalisation' do
    expect('Minus one'.in_numbers).to eq(-1)
    expect('FIVE Million, three hundred and fifty-seVen Thousand'.in_numbers).to eq(5_357_000)
    expect("FIVE,,./';';';[] Million, three hundred and fifty-seVen Thousand".in_numbers).to eq(5_357_000)
  end

  it 'should handle decimal points' do
    expect('one point one'.in_numbers).to eq(1.1)

    expect('zero point seven six five three four'.in_numbers).to eq(0.76534)
    expect('one trillion point six'.in_numbers).to eq(10**12 + 0.6)

    long_number = <<~NUMBER
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

    expect(long_number.in_numbers).to eq(
      9_777_059_160_806_736_471_970_632_827_836_952_710_801_948_705_683_106_707_757_426_795_746_813_127_465_237_139_153_046_752_803_093_791.89564321895678
    )

    expect('seventy five point eight four three two seven six nine four five one eight'
           .in_numbers).to eq(75.84327694518)
  end

  it 'should handle years notation' do
    expect('fifteen sixteen'.in_numbers).to eq(1516)
    expect('eighty five sixteen'.in_numbers).to eq(8516)
    expect('nineteen ninety six'.in_numbers).to eq(1996)
    expect('forty nine ninety eight forty seven seventy nine'.in_numbers).to eq(49_984_779)
    expect('fifteen sixteen'.in_numbers).to eq(1516)
    expect('fifteen sixteen seven'.in_numbers).to eq(15_167)
    expect('fifteen sixteen seventeen'.in_numbers).to eq(151_617)
  end
end
