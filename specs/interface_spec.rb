require 'simplecov'
SimpleCov.start

require_relative '../lib/interface.rb'

describe Interface do

  context "Twitter-facing" do

    describe "initialize" do
      pending
    end

    describe "#listen_for_challenge" do
      pending
    end

    describe "#game_on" do
      pending
    end

    describe "#send_move" do
      pending
    end

    context "#listen_for_move" do

      it "should return "win_claimed" when twitter player claims a win"
      interface - Interface.new
      TwitterStream.should_receive(:new).and_return("I win!")
      expect { interface.listen_for_move }.to_return("win_claimed")
    end

  end

  context "internally-facing" do
    describe "#request" do
      pending
    end
  end
end