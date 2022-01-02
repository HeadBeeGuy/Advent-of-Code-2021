# Advent of Code 2021 - Day 14 part 1
# Submitting my partial solution first. It looks like part 2 is designed, as
# usual, to make me rethink this implementation.

input = File.open("input.txt").readlines.map(&:strip)

polymer_template = input[0]
rules = {}

input[2..-2].each do |rule_definition|
  left, right = rule_definition.match(/([A-Z]{2}) -> ([A-Z]{1})/)[1..2]
  rules.merge!(left.split("") => right)
end

polymer = polymer_template.chars

10.times do
  # I thought that building a new array would be better than constantly trying
  # to insert characters midway through a string
  new_polymer = []

  polymer.each_cons(2).each do |a, b|
    new_polymer.push(a, rules[[a,b]])
  end

  new_polymer.push(polymer_template[-1])
  polymer = new_polymer
end

min, max = polymer.tally.values.minmax # tally requires Ruby 2.7+
puts "The max (#{max}) minus min (#{min}) is #{max - min}."
