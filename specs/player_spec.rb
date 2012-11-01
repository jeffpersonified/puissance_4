require 'SimpleCov'
SimpleCov.start

require_relative '../lib/player.rb'

describe Player do

  context "#initialize" do
    it "creates a player with a color attribute" do
      player = Player.new("red")
      player.color.should eq "red"

    end
  end

  context "#pick" do
    it "gets a number between 1 and 7 from the human" do
      player = Player.new("red")
      player.pick.should be_between(1,7)
    end
  end
end