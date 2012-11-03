require_relative '../lib/smart_ai_player'
require_relative '../lib/board'


describe SmartAIPlayer do

  let(:smart_ai_player) { SmartAIPlayer.new }

  context "#initialize" do
    it "creates a player with a name attribute" do
      smart_ai_player.name.should eq "anonymous"
    end
  end

  context "#pick" do
    it "receives a board and returns an integer between 1 and 7 from the computer" do
      smart_ai_player.pick('board').should be_between(1,7)
    end

    it "takes a winning vertical move when available" do
      board = Board.new
      board.place_piece(1,1)
      board.place_piece(1,1)
      board.place_piece(1,1)
      smart_ai_player.pick(board).should eq 1

    end

    it "takes a winning horizontal move when available" do
      board = Board.new
      board.place_piece(1,1)
      board.place_piece(1,2)
      board.place_piece(1,3)
      smart_ai_player.pick(board).should eq 4
    end
  end



end