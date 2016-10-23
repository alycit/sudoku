BOARD_SIZE = 9
BOX_SIZE = 3
FULL_ROW = (1..BOARD_SIZE).to_a.join
FULL_BOARD_ARRAY = FULL_ROW.split("")

def solve(board)
  location = get_unfilled_location(board)
  return board if location.nil?

  get_possibilities(board, location).each do |possibility|
    board[location] = possibility
    result = solve(board)
    return result if solved?(result)
  end

  board[location] = "-"
  board
end

def get_unfilled_location(board)
  board.index("-")
end

def get_possibilities(board, position)
  row = get_row_from_position(board, position)
  column = get_column_from_position(board, position)
  box = get_box_from_position(board, position)
  FULL_BOARD_ARRAY - get_unique_numbers_from_set(row + column + box)
end

def get_unique_numbers_from_set(data)
  remove_dashes(data).uniq.sort
end

def remove_dashes(set)
  set.select { |item| item != "-"}
end

def get_row_from_position(board, position)
  get_rows(board)[row_number_from(position)]
end

def get_column_from_position(board, position)
  get_columns(board)[column_number_from(position)]
end

def get_box_from_position(board, position)
  get_boxes(board)[box_number_from(position)]
end

def solved?(board)
  rows_solved?(board) && columns_solved?(board) && boxes_solved?(board)
end

def rows_solved?(board)
  set_solved?(get_rows(board))
end

def columns_solved?(board)
  set_solved?(get_columns(board))
end

def boxes_solved?(board)
  set_solved?(get_boxes(board))
end

def set_solved?(set)
  set.all?{ |row| row.sort.join == FULL_ROW }
end

def get_rows(board)
  get_board_array(board).each_slice(BOARD_SIZE).to_a
end

def get_columns(board)
  get_rows(board).transpose
end

def get_boxes(board)
  get_board_array(board).each_with_index.with_object(empty_row) do |(cell, index), boxes|
    boxes[box_number_from(index)] << cell
  end
end

def get_board_array(board)
  board.split("")
end

def empty_row
  Array.new(BOARD_SIZE) {[]}
end

def row_number_from(index)
  (index / BOARD_SIZE)
end

def column_number_from(index)
  index - (row_number_from(index) * BOARD_SIZE)
end

def box_number_from(index)
  box_row = row_number_from(index) / BOX_SIZE
  box_column = column_number_from(index) / BOX_SIZE
  box_number = (box_row * BOX_SIZE) + box_column
end

def pretty_board(board)
  get_rows(board).each_with_index.with_object("") do |(row, index), result|
    result << separator_row if separator_position?(index)
    result << pretty_row(row)
  end
end

def pretty_row(row, in_box_seprator = " ")
  row.each_slice(BOX_SIZE).map {|set| set.join(in_box_seprator) }.join(" | ") + "\n"
end

def separator_row
  pretty_row(Array.new(BOARD_SIZE) {"-"}, "-")
end

def separator_position?(position)
  position > 0 && position % BOX_SIZE == 0
end
