require 'simplecov'
SimpleCov.start

require_relative '../lib/human_player.rb'


describe HumanPlayer do

  let(:player) { HumanPlayer.new('red') }

  context "#initialize" do
    it "creates a player with a name attribute" do
      player.name.should eq "red"
    end
  end

  context "#pick" do
    it "receives a board and returns an integer between 1 and 7 from the human" do
      player.pick("board").should be_between(1,7)
    end
  end


end