require 'simplecov'
SimpleCov.start

require_relative '../lib/player.rb'

describe Player do

  let(:player) { Player.new('X') }

  context "#initialize" do
    it "creates a player with a symbol attribute" do
      player.symbol.should eq "X"
    end
  end

  context "#pick" do
    it "receives a board and returns an integer between 1 and 7 from the human" do
      expect {player.pick}.to raise_error
    end
  end

  context "#valid_input?" do
    it "returns true if valid input" do
      player.valid_input?(4).should eq true
    end

    it "returns false if invalid input" do
      player.valid_input?(9).should eq false
    end

    it "returns false if invalid input" do
      player.valid_input?("zoo").should eq false
    end
  end
end