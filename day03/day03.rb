# Advent of Code 2021 - Day 03
# This is only part 1. I've been trying to do part 2 for the last few days when
# I have time, but I keep running into errors, edge cases, and realizations
# that my approach won't work. It's been really frustrating.

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