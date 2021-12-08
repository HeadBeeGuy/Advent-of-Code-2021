# Advent of Code 2021 - Day 05
# I saw minmax while looking through Enumerable and I thought I'd try it.
# I originally made the sea floor a Hash of booleans and just incremented a
# counter when it found a true value, but it didn't work, for some reason.
# There's no reason to count how many vents overlap in each position, but it's
# at least an understandable way to solve the problem.
# There must be a more mathematical way to find overlapping points without
# manually stepping through each line like this, but it hasn't occured to me yet.

input = File.open("input.txt")
vent_lines = input.readlines

sea_floor = Hash.new(0) # part 1 answer
sea_floor_diagonal = Hash.new(0) # part 2 answer

vent_lines.each do |line|
  # I started using destructuring in Day 4, so now I have to use it everywhere
  x1, y1, x2, y2 = line.match(/([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)/)[1..].map(&:to_i)

  if x1 == x2
    min, max = [y1, y2].minmax
    (min..max).each do |y|
      sea_floor[[x1, y]] += 1
      sea_floor_diagonal[[x1, y]] += 1
    end
  elsif y1 == y2
    min, max = [x1, x2].minmax
    (min..max).each do |x|
      sea_floor[[x, y1]] += 1
      sea_floor_diagonal[[x, y1]] += 1
    end
  else # diagonal
    # there's probably a clearer way to do this
    delta_x = x1 - x2
    delta_y = y1 - y2
    x_increment = delta_x < 0 ? 1 : -1
    y_increment = delta_y < 0 ? 1 : -1

    (delta_x.abs + 1).times do
      sea_floor_diagonal[[x1, y1]] += 1
      x1 += x_increment
      y1 += y_increment
    end
  end
end

# puts sea_floor.inspect
puts "Overlapping vents, not considering diagonal lines: #{sea_floor.values.select { |a| a > 1}.size }"
puts "Overlapping vents, considering diagonal lines: #{sea_floor_diagonal.values.select { |a| a > 1}.size }"