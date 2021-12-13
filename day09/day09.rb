# Advent of Code 2021 - Day 09
# I felt pretty out of my depth (as it were) on this one, and managed to solve
# it with a fairly naive simulation. I imagine that there are much shorter,
# clearer ways to solve this. One optimization I thought of is to completely
# discard 9 values, since they can never be minima or included in basins.
# I imagine that this is supposed to familiarize me with graph-related problems
# that will come later, but I fear that I didn't learn much...

input = File.open("input.txt")
floor_map_info = input.readlines.map(&:strip)

max_x = floor_map_info.first.length - 1
max_y = floor_map_info.size - 1

floor_map = {}

floor_map_info.each_with_index do |line, y|
  line.each_char.with_index do |height, x|
    unless height == "9"
      floor_map[[x,y]] = height.to_i
    end
  end
end

minima = {}

floor_map.each do |coordinate, height|
  x, y = coordinate[0], coordinate[1]
  found_lower_point = false

  surrounding_points = [[x, y - 1], [x - 1, y], [x + 1, y], [x, y + 1]]

  surrounding_points.each do |point|
    if floor_map.has_key?(point) && floor_map[[point[0], point[1]]] <= height
      found_lower_point = true
    end
  end

  if found_lower_point == false
    minima.merge!({[x,y] => height})
  end

end
puts "The total risk level sum is #{minima.values.sum + minima.values.size}"
basin_sizes = []

# There has to be a better way to quickly get the surrounding area, right?
minima.each do |coordinate, height|
  basin_points = {}
  new_points = [coordinate]

  while new_points.any?
    current_point = new_points.pop()

    x, y = current_point[0], current_point[1]
    surrounding_points = [[x, y - 1], [x - 1, y], [x + 1, y], [x, y + 1]]
    surrounding_points.each do |point|
      if floor_map.has_key?(point) && !basin_points.has_key?(point)
        basin_points.merge!({point => true})
        new_points.push(point)
      end
    end
  end
  basin_sizes << basin_points.size
end

puts "The product of the 3 largest basins is #{basin_sizes.sort[-3..].reduce(:*)}"