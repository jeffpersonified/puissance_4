require 'simplecov'
SimpleCov.start

require_relative '../lib/player.rb'
require_relative '../lib/game.rb'

describe Game do

  let(:game) { Game.new }

  context 'communication with player' do

    it "creates two instances of the player class and assigns colors" do
      game.p1.symbol.should eq('O')
      game.p2.symbol.should eq('X')
    end

  end

  context 'communication with board' do

    it "receives a board object upon initialize" do
      game.board.should be_an_instance_of(Board)
    end

    context "#winning_combo?" do

      it "knows when the board has a winning combo" do
        game.board.stub!(:winning_combo?).and_return(true)
        game.winning_combo?.should be_true
      end

      it "knows when the board does not have a winning combo" do
        game.board.stub!(:winning_combo?).and_return(false)
        game.winning_combo?.should be_false
      end

    end

    context "#place_piece" do

      it "places a piece if there is space available in the column" do
        game.board.stub!(:place_piece).and_return(true)
        game.place_piece(:player, :column).should be_true
      end

      it "returns an error if there is NOT space available in the column" do
        game.board.stub!(:place_piece).and_raise(ColumnFullError)
        expect { game.place_piece(:player, :column) }.to raise_error(ColumnFullError)
      end

    end

  end

end



