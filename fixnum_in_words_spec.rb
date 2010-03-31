require 'fixnum_in_words'
describe Fixnum do
  it "should print the digits 0-9 correctly" do
    numbers = %w[zero one two three four five six seven eight nine ten]
    10.times do |i|
      i.in_words.should==numbers[i]
    end
  end

end

