# Advent of Code 2021 - Day 06
# I completely changed my implementation for part 2. I didn't do the most obvious
# item-by-item array simulation since the problem was probably designed to
# overwhelm that, but my part 1 solution made an array too big for Ruby to handle.
# I eventually realized that each fish with the same birthday is essentially
# identical. If 5 fish all have the same birthday, they make 5 new fish at
# regular intervals. They never die, so they just reproduce at a fixed rate and
# the only question is how many offspring their offspring produces over time.

input = File.open("input.txt")
initial_fish = input.readlines.first.strip.split(",").map(&:to_i)
total_fish = 0
days = 256 # change to 80 for part 1

new_fish_for_date = Hash.new(0) # key: date  value: how many fish are born on this date

# work backwards for the birthdays of the original fish
initial_fish.each do |fish|
  total_fish += 1
  fish_birthday = fish - 8
  new_fish_for_date[fish_birthday] += 1
end

oldest_fish_day = new_fish_for_date.keys.min

(oldest_fish_day..days).to_a.each do |day|
  new_fish_today = new_fish_for_date[day]
  unless new_fish_today == 0
    # every fish on this day has its original 9 day cycle first
    spawn_dates = ((day + 9)..days).step(7).to_a

    # the nice thing is, if we're near the end, spawn_dates is an empty Array
    spawn_dates.each do |date|
      # make baby fish, who we will track in due course
      new_fish_for_date[date] += new_fish_today
      total_fish += new_fish_today
    end
  end
end

puts "At the end of day #{days}, there are #{total_fish} fish."