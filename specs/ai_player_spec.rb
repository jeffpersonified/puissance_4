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
      player.pick('board').should be_between(1,7)
    end
  end

end