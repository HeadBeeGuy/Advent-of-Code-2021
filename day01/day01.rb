# Advent of Code 2021 - Day 01
# I thought I'd be clever and use something like reduce, but I wondered how I'd
# look back at the previous element in the array.
# I stumbled across the each_cons method when I was looking through Enumerable,
# and it made this very simple. But I'm sure there's a more clever way to do this
# with map, reduce, and friends.

def number_of_increasing_elements(arr)
  increasing_elements = 0
  arr.each_cons(2) do |a, b|
    increasing_elements += 1 if b > a
  end
  increasing_elements
end

input = File.open("input.txt")
depths = input.readlines.map(&:to_i)

puts "Part 1 answer: #{number_of_increasing_elements(depths)}"

triplet_sums = []
depths.each_cons(3) do |a, b, c|
  triplet_sums << a + b + c
end

puts "Part 2 answer: #{number_of_increasing_elements(triplet_sums)}"