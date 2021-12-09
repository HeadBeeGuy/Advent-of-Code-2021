# Advent of Code 2021 - Day 06 part 1
# This one took me a while to ponder. I imagined that doing a simple simulation
# would, by design, make it take unfeasibly long. So I tried to look at it
# vertically, for lack of a better word. Take each fish, see how many times it
# has a chance to spawn a new fish in the length of the simulation, then see
# how many times those fish have chances to spawn fish given their starting dates.
# Unfortunately, this approach seems to overwhelm Ruby in part 2. Maybe I should 
# make a linked list data structure?

input = File.open("input.txt")
initial_fish = input.readlines.first.strip.split(",").map(&:to_i)
days = 80

# take all of our initial fish, then work backwards to their initial birth dates
fish = initial_fish.map{ |i| i -= 8 }

fish.each do |fish_birthday|
  # assuming that each fish we encounter is on its first spawn cycle
  next_spawn_date = fish_birthday + 9

  while next_spawn_date <= days do
    fish.push(next_spawn_date)
    next_spawn_date += 7
  end
end

puts "In the end, there were #{fish.size} fish by day #{days}."