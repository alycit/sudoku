require 'simplecov'

SimpleCov.start

require_relative '../sudoku'

describe 'sudoku' do
  let(:board) { "1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--" }
  let(:solved_board) {"145892673893176425276435819519247386762583194384961752957614238438729561621358947"}
  let(:duplicate_in_row_col_box) {"145892673893176425276435819549247386762583194384961752957614238438729561621358947"}

  context '#solve' do
    it "returns the board if it's already solved" do
      expect(solve(solved_board)).to eq solved_board
    end

    it "returns the full solved board when it's solved" do
      expect(solve(board)).to eq solved_board
    end
  end

  context "#get_unfilled_location" do
    it "returns nil for a solved board" do
      expect(get_unfilled_location(solved_board)).to eq nil
    end

    it "returns the position for an unsolved board" do
      expect(get_unfilled_location(board)).to eq 1
    end
  end

  context "#get_possibilities" do
    it "returns the full set of unique possibilities for a position" do
      expect(get_possibilities(board, 1)).to eq ["4","7"]
    end

    it "returns an empty array for no possibilities" do
      board = "14583267--9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--"
      expect(get_possibilities(board, 8)).to eq []
    end
  end

  context '#solve?' do
    context "valid board" do
      it "returns true when a board is fully solved" do
        expect(solved?(solved_board)).to eq true
      end
    end

    context "invalid board" do
      it 'returns false when a board contains dashes' do
        expect(solved?(board)).to eq false
      end

      it "returns false when a board is invalid" do
        expect(solved?(duplicate_in_row_col_box)).to eq false
      end
    end
  end

  context "#rows_solved?" do
    context "valid board" do
      it "returns true if all rows have exactly 1 through 9" do
        expect(rows_solved?(solved_board)).to eq true
      end
    end
    context "invalid board" do
      it "returns false a row has a duplicate number" do
        expect(rows_solved?(duplicate_in_row_col_box)).to eq false
      end
    end
  end

  context "#columns_solved?" do
    context "valid board" do
      it "returns true if all columns have exactly 1 through 9" do
        expect(columns_solved?(solved_board)).to eq true
      end
    end
    context "invalid board" do
      it "returns false if column has a duplicate number" do
        expect(columns_solved?(duplicate_in_row_col_box)).to eq false
      end
    end
  end

  context "#boxes_solved?" do
    context "valid board" do
      it "returns true if all boxes have exactly 1 through 9" do
        expect(boxes_solved?(solved_board)).to eq true
      end
    end
    context "invalid board" do
      it "returns false if a box has a duplicate number" do
        expect(boxes_solved?(duplicate_in_row_col_box)).to eq false
      end
    end
  end

  context '#pretty_board' do
    it "displays a pretty representation of an unsolved board" do
      expect(pretty_board(board)).to eq  "1 - 5 | 8 - 2 | - - -\n- 9 - | - 7 6 | 4 - 5\n2 - - | 4 - - | 8 1 9\n----- | ----- | -----\n- 1 9 | - - 7 | 3 - 6\n7 6 2 | - 8 3 | - 9 -\n- - - | - 6 1 | - 5 -\n----- | ----- | -----\n- - 7 | 6 - - | - 3 -\n4 3 - | - 2 - | 5 - 1\n6 - - | 3 - 8 | 9 - -\n"
    end

    it "displays a pretty representation of a solved board" do
      expect(pretty_board(solved_board)).to eq "1 4 5 | 8 9 2 | 6 7 3\n8 9 3 | 1 7 6 | 4 2 5\n2 7 6 | 4 3 5 | 8 1 9\n----- | ----- | -----\n5 1 9 | 2 4 7 | 3 8 6\n7 6 2 | 5 8 3 | 1 9 4\n3 8 4 | 9 6 1 | 7 5 2\n----- | ----- | -----\n9 5 7 | 6 1 4 | 2 3 8\n4 3 8 | 7 2 9 | 5 6 1\n6 2 1 | 3 5 8 | 9 4 7\n"
    end
  end

  context "#box_number_from" do
  end
end
