# Advent of Code 2021 - Day 02
# This is just a quick and simple parse that accumulates a handful of values
# as it goes.

input = File.open("input.txt")
commands = input.readlines

depth = {part1: 0, part2: 0}
horizontal_position = {part1: 0, part2: 0}
aim = 0

commands.each do |command|
  directions = /([a-z])[a-z]+ ([0-9]+)/.match(command).captures
  amount = directions[1].to_i
  case directions[0]
  when "f"
    horizontal_position[:part1] += amount
    horizontal_position[:part2] += amount
    depth[:part2] += aim * amount
  when "d"
    depth[:part1] += amount
    aim += amount
  when "u"
    depth[:part1] -= amount
    aim -= amount
  else
    "The submarine was provided with an invalid command."
  end
end

puts "Answer for part 1: #{depth[:part1] * horizontal_position[:part1]}"
puts "Answer for part 2: #{depth[:part2] * horizontal_position[:part2]}"