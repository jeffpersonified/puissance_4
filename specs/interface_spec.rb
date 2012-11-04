require 'simplecov'
SimpleCov.start

require '../lib/interface.rb'

describe Interface do

  # context "Twitter-facing" do
  #
  #   describe "#listen_for_challenge" do
  #     pending
  #   end
  #
  #   describe "#game_on" do
  #     pending
  #   end
  #
  #   describe "#send_move" do
  #     pending
  #   end
  #
  #   context "#listen_for_move" do
  #
  #     it "should return win_claimed when twitter player claims a win" do
  #     end
  #
  #     only listens to tweets with proper hash do
  #     end
  #
  #     respond to tie do
  #     end
  #
  #     it "should tweet an error when an invalid move is given" do
  #       pending
  #     end
  #
  #   end
  #
  # end

  context "internally-facing" do
    describe "#request" do
      it "should return a board correlates to the board tweeted" do
        pending
      end
    end
  end
end