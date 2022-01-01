# Advent of Code 2021 - Day 13
# I tried Ruby's Set for the first time after reading about them in Swift. I
# should've used this for all the previous problems where I used a Hash solely
# for checking inclusion but didn't care about the value.
# I'm representing everything how I view it visually as the paper folds, but
# there has to be a quicker, more mathematical way to represent what's
# happening.

require 'set'

def print_set(dot_set)
  max_x = dot_set.map { |x| x[0] }.max
  max_y = dot_set.map { |y| y[1] }.max

  (0..max_y).each do |y|
    (0..max_x).each do |x|
      if dot_set.include?([x,y])
        print "#"
      else
        print " "
      end
    end
    print "\n"
  end
  print "\n"
end

input = File.open("input.txt")
paper = input.readlines.map(&:strip)

dot_set = Set.new()
instructions = []
sizes_after_fold = [] # don't need to store all of them, but this eliminates checking in the loop

# unnecessarily checking each line, but we could mix instructions if we want
paper.each do |instruction|
  if instruction.start_with?(/[0-9]/)
    x, y = instruction.split(",").map(&:to_i)
    dot_set << [x, y]
  elsif instruction.start_with?("fold")
    axis, line = instruction.match(/(x|y)=([0-9]+)/)[1..2]
    line = line.to_i
    if axis == "x"
      left, right = dot_set.partition { |coord| coord[0] < line }
      right_folded = right.map { |x| [(line - (x[0] - line).abs), x[1]] }
      dot_set = Set.new(left).merge(Set.new(right_folded))
    else
      above, below = dot_set.partition { |coord| coord[1] < line }
      below_folded = below.map { |x| [ x[0], (line - (x[1] - line).abs) ] }
      dot_set = Set.new(above).merge(Set.new(below_folded))
    end
    sizes_after_fold << dot_set.size
  end
end

puts "After the first fold, there are #{sizes_after_fold[0]} dots."
puts "After all the folds, it looks like:"
print_set(dot_set)

