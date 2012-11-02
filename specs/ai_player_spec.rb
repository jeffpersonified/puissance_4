require 'simplecov'
SimpleCov.start

require_relative '../lib/ai_player.rb'


describe AIPlayer do

  let(:player) { AIPlayer.new('red') }

  context "#initialize" do
    it "creates a player with a name attribute" do
      player.name.should eq "red"
    end
  end

  context "#pick" do
    it "receives a board and returns an integer between 1 and 7 from the computer" do
      rand_num = rand(1..7)
      player.stub(:pick).and_return(rand_num)
      ('board').should be_between(1,7)
    end

    it "raises an error when it receives input not between 1 and 7" do
      player.stub(:pick).and_return("A")
      player.pick.should raise_error
    end

    it "stores a board received from game" do
      player.pick("board")
      player.current_board.should eq("board")
    end
  end

end