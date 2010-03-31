require 'numbers_to_words'
def usage code=-1
  puts "\nUsage:\n\nruby #{__FILE__} <start> <end>"
  exit code
end
if ARGV.length != 2

  puts "Start and end arguments expected"
  usage -1
end
start_number = ARGV[0].to_i
end_number = ARGV[1].to_i

if start_number > end_number
  puts "Start number must be less than or equal to the end number"
  usage -2
end

for i in start_number..end_number do
  puts i.in_words
end
