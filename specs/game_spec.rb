require 'simplecov'
SimpleCov.start

require_relative '../lib/player.rb'
require_relative '../lib/game.rb'

describe Game do

  let(:game) { Game.new }

  context 'communication with player' do

    it "creates two instances of the player class and assigns colors" do
      game.red_player.color.should eq('red')
      game.blue_player.color.should eq('blue')
    end

    it "receives a column number when asking a specific player to pick" do
      column_pick = rand(1..7)
      game.red_player.stub!(:pick).and_return(column_pick)
      game.target_column.should eq(column_pick)
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



