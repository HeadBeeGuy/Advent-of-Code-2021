# Advent of Code 2021 - Day 10
# I remember reading a recent blog for Visual Studio Code talking about how
# matching parenthesis was, at least in a simplistic implementation, a matter
# of matching brackets on a stack. There's probably a way to make the big
# case statement much shorter, but it works well enough.
# I did this one out of order since the solution seemed easier to come up with
# than some of the other days I haven't gotten to yet.

input = File.open("input.txt")
chunk_list = input.readlines.map(&:strip)
error_score = 0
completion_scores = []
completion_score_values = {"(" => 1, "[" => 2, "{" => 3, "<" => 4}

chunk_list.each do |chunk|
  stack = []
  error_encountered = false

  chunk.each_char do |char|
    case char
    when '(', '[','{','<'
      stack.push(char)
    when ')'
      if stack.pop() != '('
        error_score += 3
        error_encountered = true
        break
      end
    when ']'
      if stack.pop() != '['
        error_score += 57
        error_encountered = true
        break
      end
    when '}'
      if stack.pop() != '{'
        error_score += 1197
        error_encountered = true
        break
      end
    when '>'
      if stack.pop() != '<'
        error_score += 25137
        error_encountered = true
        break
      end
    end
  end

  if stack.any? && !error_encountered
    # all we need to do is walk backwards from the remaining brackets and tally up the score
    new_completion_score = 0
    stack.reverse.each do |char|
      new_completion_score = (new_completion_score * 5) + completion_score_values[char]
    end

    completion_scores << new_completion_score
  end
end

puts "The final error score was #{error_score}."
puts "The middle completion string score was #{completion_scores.sort[completion_scores.length / 2]}."