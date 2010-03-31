require 'fixnum_in_words'
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


end

