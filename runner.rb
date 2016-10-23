require_relative 'sudoku'

File.readlines("sudoku_puzzles.txt").each_with_index do |board_string, index|
  processed_board = solve(board_string.chomp)
  puts "\n" + pretty_board(processed_board) + "\n"
  solved?(processed_board) ? (puts "Board #{index+1} was solved!") : (puts "Board #{index+1} wasn't solved :(")
  sleep 0.5
end
