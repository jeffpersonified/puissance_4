require_relative '../lib/smart_ai_player'
require_relative '../lib/board'


describe SmartAIPlayer do
  let(:smart_ai_player) { SmartAIPlayer.new('X') }
  let(:board) { Board.new }

  context "#initialize" do
    it "creates a player with a symbol attribute" do
      smart_ai_player.symbol.should eq "X"
    end
  end

  context "#pick" do
    it "receives a board and returns an integer between 1 and 7 from the computer" do
      smart_ai_player.pick(board).should be_between(1,7)
    end
    
    it "takes a winning vertical move when available" do
      3.times { board.place_piece('X',1) }
      smart_ai_player.pick(board).should eq 1
    end

    it "takes a winning horizontal move when available" do
      3.times { |i| board.place_piece('X',i+1) }
      smart_ai_player.pick(board).should eq 4
    end
    
    it "takes a winning diagonal move when available" do
      board.place_piece('X',2)
      1.times { board.place_piece('O',3) }
      board.place_piece('X',3)
      2.times {board.place_piece('O',4)}
      board.place_piece('X',4)
      3.times {board.place_piece('O',5)}
      smart_ai_player.pick(board).should eq 5
    end
    
    it "takes a winning diagonal move when available" do
      2.times { board.place_piece('O',1) }
      board.place_piece('X',1)
      2.times{ board.place_piece('O',2) }
      board.place_piece('X',2)
      1.times{ board.place_piece('O',3) }
      board.place_piece('X',3)
      board.place_piece('X',4)
      smart_ai_player.pick(board).should eq 1
    end
  end



end