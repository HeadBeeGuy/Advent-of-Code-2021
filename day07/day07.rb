# Advent of Code 2021 - Day 7
# I think that there must be something mathematical that expresses the core of
# this problem - how can we find a number such that the sum of the differences
# between it and a list of numbers is as small as possible? - but I didn't know
# about it, so I solved the problem in its tedious manual form.
# When running the calculations, I try to combine every crab that starts at the
# same position, since the distance between them and the point will always be the
# same, and there's no reason to run the numbers multiple times.


# for part 2, I looked up 1 + 2 + 3 + 4 + 5 and sure enough, this is a pattern:
# https://en.wikipedia.org/wiki/1_%2B_2_%2B_3_%2B_4_%2B_%E2%8B%AF
# this function pre-computes the values, since we'll have to compute them a bunch 
# for part 2 anyway.
def compute_triangular_numbers(up_to)
  triangular_numbers = {}
  (0..up_to).each do |num|
    triangular_numbers.merge!({num => ( num * ( num + 1 ) ) / 2})
  end
  triangular_numbers
end

input = File.open("input.txt")
# I stumbled across the super handy tally method here: https://stackoverflow.com/a/56673968
crabs_at_position = input.readlines.first.strip.split(",").map(&:to_i).sort.tally

initial_positions_range = crabs_at_position.keys

minimum = initial_positions_range.first
maximum = initial_positions_range.last
part_2_fuel_cost = compute_triangular_numbers(maximum - minimum)

best_position_part_1 = nil
lowest_difference_part_1 = 1_000_000_000 # big enough for the confines of this problem
best_position_part_2 = nil
lowest_difference_part_2 = 1_000_000_000

(minimum..maximum).to_a.each do |potential_position|
  total_difference_part_1 = 0
  total_difference_part_2 = 0
  initial_positions_range.each do |position|
    distance = (potential_position - position).abs
    total_difference_part_1 += distance * crabs_at_position[position]
    total_difference_part_2 += part_2_fuel_cost[distance] * crabs_at_position[position]
  end
  if total_difference_part_1 < lowest_difference_part_1
    best_position_part_1 = potential_position
    lowest_difference_part_1 = total_difference_part_1
  end
  if total_difference_part_2 < lowest_difference_part_2
    best_position_part_2 = potential_position
    lowest_difference_part_2 = total_difference_part_2
  end
end

puts "Assuming 1 fuel per space, the best position will be #{best_position_part_1}, consuming a total of #{lowest_difference_part_1} fuel."
puts "Assuming rising fuel per space, the best position will be #{best_position_part_2}, consuming a total of #{lowest_difference_part_2} fuel."