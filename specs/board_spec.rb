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

  describe "#connect_four?" do
    context "checking the rows" do
      let(:winning_board_horizontal){
        [ ["","","","","",""],
          [1 ,"","","","",""],
          [1 ,"","","","",""],
          [1 ,"","","","",""],
          [1 ,"","","","",""],
          ["","","","","",""],
          ["","","","","",""] ]
      }
      it "returns true if a row contains four consecutive pieces" do
        winning_board_horizontal.connect_four?.should be_true
      end
      it "returns false if no row contains four consecutive pieces" do
        winning_board_horizontal.connect_four?.should be_false
      end
    end
    context "checking the columns" do
      let(:winning_board_vertical){
        [ ["","","","","",""],
          [1 ,1 ,1 ,1 ,"",""],
          ["","","","","",""],
          ["","","","","",""],
          ["","","","","",""],
          ["","","","","",""],
          ["","","","","",""] ]
      }
      it "returns true if a column contains four consecutive pieces" do
        winning_board_vertical.connect_four?.should be_true
      end
      it "returns false if no column contains four consecutive pieces" do
        winning_board_vertical.connect_four?.should be_false
      end
    end
    context "checking the diagonal" do
      let(:winning_board_diagonal){
        [ ["","","","","",""],
          [1 ,"","","","",""],
          ["",1 ,"","","",""],
          ["","",1 ,"","",""],
          ["","","",1 ,"",""],
          ["","","","","",""],
          ["","","","","",""] ]
      }
      it "returns true if a diagonal contains four consecutive pieces" do
        winning_board_diagonal.connect_four?.should be_true
      end
      it "returns false if no diagonal contains four consecutive pieces" do
        winning_board_diagonal.connect_four?.should be_false
      end
    end
  end


  # context "#connect_four?" do
  #     context "when there isn't a connect four" do
  #       it "returns false" do
  #
  #       end
  #     end
  #
  #     context "when there is..." do
  #       board.place(2)
  #       board.place(3)
  #       board.place(4)
  #       board.place(2)
  #       board.should be_connect_four
  #     end
  #   end
  #
  #   context "#full?" do
  #   end


end

# board.columns.any?(&:four_in_a_row?)
# board.rows.any?(&:four_in_a_row?)
# board.diagonals.any?(&:four_in_a_row?)
#
# board.columns.any? { |col| col.four_in_a_row? }


# [ [ ,  ,  ,  ,  , ],
#   [ ,  ,  ,  ,  , ],
#   [ ,  ,  ,  ,  , ],
#   [ ,  ,  ,  ,  , ],
#   [ ,  ,  ,  ,  , ],
#   [ ,  ,  ,  ,  , ],
#   [ ,  ,  ,  ,  , ] ]