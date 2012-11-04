require 'simplecov'
SimpleCov.start

require_relative '../lib/twitter_player.rb'

describe TwitterPlayer do
  let(:player) { TwitterPlayer.new }

  context "pick" do
    it "returns a integer between 1 and 7" do
      # this test isn't working and I'm not sure how to get it to work right now
      # matt
      player.pick("board").should be_between(1,7)
    end
  end
end