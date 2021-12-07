# Advent of Code 2021 - Day 03
# Part 2 took me a really long time with lots of dead ends and mishaps.
# I was hoping to do everything in one parse of the array, but I was
# getting pretty tired of the problem and went with a solution that I'm sure
# leaves plenty of performance on the table.

input = File.open("input.txt")
diagnostic_report = input.readlines.map(&:strip)

bits = Hash.new(0)

diagnostic_report.each do |report_line|
  report_line.chars.each_with_index do |bit, index|
    case bit
    when "0"
      bits[index] -= 1
    when "1"
      bits[index] += 1
    else
      puts "This is supposed to be binary!"
    end
  end
end

gamma_rate = ""
epislon_rate = ""

bits.keys.sort.each do |position|
  case
  when bits[position] > 0
    gamma_rate << "1"
    epislon_rate << "0"
  else
    gamma_rate << "0"
    epislon_rate << "1"
  end
end

puts "The power consumption is #{gamma_rate.to_i(2) * epislon_rate.to_i(2)}"

oxygen_rating = ""
co2_rating = ""

acc = ""
candidates = diagnostic_report
loop do
  if candidates.length <= 1
    oxygen_rating = candidates.first
    break
  end
  # This is the first time I've done destructuring in Ruby!
  zeros, ones = candidates.partition { |a| a.start_with?(acc + "0") }
  if ones.length >= zeros.length
    acc += "1"
    candidates = ones
  else
    acc += "0"
    candidates = zeros
  end
end

acc = ""
candidates = diagnostic_report
loop do
  if candidates.length <= 1
    co2_rating = candidates.first
    break
  end
  zeros, ones = candidates.partition { |a| a.start_with?(acc + "0") }
  if zeros.length <= ones.length
    acc += "0"
    candidates = zeros
  else
    acc += "1"
    candidates = ones
  end
end

puts "The life support rating is #{oxygen_rating.to_i(2) * co2_rating.to_i(2)}"