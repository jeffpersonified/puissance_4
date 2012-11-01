require 'SimpleCov'
SimpleCov.start

require_relative '../lib/player.rb'

require_relative '../lib/game.rb'

describe Game do

  context 'communication with player' do

    it "creates two instances of the player class and assigns colors" do
      game = Game.new
      game.red_player[:color].should eq('red')
      game.blue_player[:color].should eq('blue')
    end

    it "receives a column number when asking a player to pick" do
      game = Game.new
      game.insertion_target_column.should be_between(1,7)
    end

  end

  # context 'communication with board' do
  #
  # end

end