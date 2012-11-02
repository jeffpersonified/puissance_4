require 'simplecov'
SimpleCov.start

require '../lib/board.rb'

describe Board do
  let(:board){ Board.new }

  describe "#place_piece" do
    context "when somebody has played on an empty board" do
      it "changes the string output" do
        board.place_piece(1, 2)
        board_after = [ ["","","","","",""],
                        [1 ,"","","","",""],
                        ["","","","","",""],
                        ["","","","","",""],
                        ["","","","","",""],
                        ["","","","","",""],
                        ["","","","","",""] ]
        board.cells.should eq board_after
      end
    end

    context "when somebody has played" do
      it "changes the string output" do
        3.times { board.place_piece(1, 2) }
        board_after = [ ["","","","","",""],
                        [1 ,1 ,1 ,"","",""],
                        ["","","","","",""],
                        ["","","","","",""],
                        ["","","","","",""],
                        ["","","","","",""],
                        ["","","","","",""] ]
        board.cells.should eq board_after
      end
    end
    context "when somebody has played on a full column" do
      it "changes the string output" do
        6.times { board.place_piece(1, 2) }
        expect { board.place_piece(1, 2) }.to raise_error(ColumnFullError)
      end
    end
  end

  describe "#winning_combo?" do
    let(:board){ Board.new }

    context "checking an empty board" do
      it "throws an error if I check for a winning combo when the board is empty" do
        expect { board.winning_combo? }.to raise_error(BoardEmptyError)
      end
    end

    context "checking the rows" do
      it "returns true if a row contains four consecutive pieces" do
        board.place_piece(1,2)
        board.place_piece(1,3)
        board.place_piece(1,4)
        board.place_piece(1,5)
        board.winning_combo?.should be_true
      end

      it "returns false if no row contains four consecutive pieces" do
        board.place_piece(1,2)
        board.winning_combo?.should be_false
      end
    end
    context "checking the columns" do
      it "returns true if a column contains four consecutive pieces" do
        board.place_piece(1,1)
        board.place_piece(1,1)
        board.place_piece(1,1)
        board.place_piece(1,1)
        board.winning_combo?.should be_true
      end
      it "returns false if no column contains four consecutive pieces" do
        board.place_piece(1,1)
        board.winning_combo?.should be_false
      end
    end
    context "checking the diagonal" do
      it "returns true if a diagonal (left to right) contains four consecutive pieces" do
        board.place_piece(1,1)
        board.place_piece(2,2)
        board.place_piece(1,2)
        2.times {board.place_piece(2,3)}
        board.place_piece(1,3)
        3.times {board.place_piece(2,4)}
        board.place_piece(1,4)
        board.winning_combo?.should be_true
      end
      it "returns true if another diagonal (left to right) contains four consecutive pieces" do
        board.place_piece(2,1)
        board.place_piece(1,2)
        board.place_piece(1,3)
        board.place_piece(1,4)
        board.place_piece(2,2)
        board.place_piece(1,3)
        board.place_piece(1,4)
        board.place_piece(2,3)
        board.place_piece(1,4)
        board.place_piece(2,4)
        board.winning_combo?.should be_true
      end
      it "returns true if a diagonal (right to left) contains four consecutive pieces" do
        board.place_piece(1,1)
        3.times{ board.place_piece(2,1) }
        board.place_piece(1,2)
        2.times{ board.place_piece(2,2) }
        board.place_piece(1,3)
        board.place_piece(2,3)
        board.place_piece(2,4)
        board.winning_combo?.should be_true
      end
      it "returns true if a diagonal (right to left) contains four consecutive pieces" do
        board.place_piece(1,4)
        board.place_piece(2,4)
        board.place_piece(1,4)
        board.place_piece(2,4)
        board.place_piece(1,4)
        board.place_piece(2,4)
        board.place_piece(1,5)
        board.place_piece(2,5)
        board.place_piece(1,5)
        board.place_piece(2,5)
        board.place_piece(2,5)
        board.place_piece(2,6)
        board.place_piece(1,6)
        board.place_piece(2,6)
        board.place_piece(2,6)
        board.place_piece(2,7)
        board.place_piece(1,7)
        board.place_piece(2,7)
        board.winning_combo?.should be_true
      end
      it "returns false if no diagonal contains four consecutive pieces" do
        board.place_piece(1,1)
        board.winning_combo?.should be_false
      end
    end
  end
end
