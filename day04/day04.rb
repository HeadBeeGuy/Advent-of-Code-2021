# Advent of Code 2021 - Day 04
# I just made a BingoBoard class and stuffed all the checks and representation
# in it. This isn't very short or clever, but it does what it has to, and finishes
# quickly enough to not be weighed down by its inefficiencies.
# If I had to work with arbitrarily-sized bingo cards, I thought about generating
# arrays full of potential bingos upon card creation, and then checking for bingos
# by seeing if any of them were empty. Maybe squid bingo will make a return later!

class BingoBoard

  @board = {}
  @completed = false

  def initialize(board_values)
    @board = create_board(board_values)
  end

  def print
    puts @board.values.select{ |h| h[:x] == 1 && h[:marked] == true}
  end

  def mark(square_value, options = {})
    if !@board.has_key?(square_value)
      return nil
    end

    @board[square_value][:marked] = true

    if check_for_bingo(square_value)
      return square_value * point_value_of_remaining_squares
    end

    nil
  end

  def completed?
    @completed
  end

  private

  def create_board(board_values)
    # board_values is an array of 6 values:
    # empty string (was a newline), then 5 strings of 5 integers
    # structure of each item: {number: {x: X, y: Y, marked: bool}}
    # this makes marking very fast, but checking for bingos clunkier.
    board = {}
    5.times do |row|
      new_row = board_values.shift.split(" ").map(&:to_i)
      new_row.each_with_index do |square, index|
        board.merge!({square => {x: index, y: row, marked: false}})
      end
    end
    
    board
  end

  def check_for_bingo(square_value)
    # inefficient for checking - have to look at every item in the hash
    current_column = @board[square_value][:x]
    if @board.values.select{ |a| a[:x] == current_column && a[:marked] == true }.size == 5
      @completed = true
      return true
    end

    current_row = @board[square_value][:y]
    if @board.values.select{ |a| a[:y] == current_row && a[:marked] == true }.size == 5
      @completed = true
      return true
    end
    
    false
  end

  def point_value_of_remaining_squares
    @board.select{ |k, v| v[:marked] == false }.keys.sum
  end

end

input = File.open("input.txt")
bingo_info = input.readlines.map(&:strip)

# reversing the array of numbers so I can read in new numbers with pop
bingo_numbers = bingo_info[0].split(",").map(&:to_i).reverse

all_boards = []

# each bingo board is a newline, plus 5 lines of 5 ints
bingo_info[1..].each_slice(6) do |slice|
  all_boards << BingoBoard.new(slice[1..])
end

board_count = all_boards.size

bingo_count = 0
found_first_bingo = false
found_last_bingo = false
first_bingo_score = 0
last_bingo_score = 0

while !found_last_bingo do
  new_number = bingo_numbers.pop

  all_boards.each do |board|
    unless board.completed?
      result = board.mark(new_number)
      unless result.nil? 
        bingo_count += 1
        if found_first_bingo == false
          first_bingo_score = result
          found_first_bingo = true
        elsif bingo_count == board_count
          last_bingo_score = result
          found_last_bingo = true
        end
      end
    end
  end

end

puts "First bingo score: #{first_bingo_score}  Final bingo score: #{last_bingo_score}"
puts "Look, kid, let the squid win."