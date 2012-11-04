require 'tweetstream'
require 'twitter'

require_relative '../twitter_credentials'
require_relative 'board_conversion'
require_relative 'game'
require_relative 'player'
require_relative 'human_player'
require_relative 'ai_player'
require_relative 'twitter_player'
require_relative 'board'
require_relative 'errors'


class Interface
  include BoardConversion

  attr_accessor :game

  def self.find_twitter_game # We need to discuss the order because a facory method can't assign instance variables until after the instance exists.
    temp_self = self.new
    temp_self.game = Game.new
    player1 = HumanPlayer.new("X")
    player2 = TwitterPlayer.new("O",temp_self)
    puts player2.inspect
    temp_self.game.first_player = player1
    temp_self.game.second_player = player2
    temp_self.listen_for_challenge
    temp_self.game_on
    puts temp_self.inspect
    outcome = temp_self.run_game
    end_game(outcome)
    # temp_self.reconcile_outcome
  end

  def run_game
    move_outcome = @game.move
    while move_outcome[0] == "continue"
      move_outcome = @game.move
    end
    move_outcome
  end

  def request(board)
    send_move(board)
    @claimed_outcome = listen_for_move
    string_to_board(@new_board)
  end

  def listen_for_challenge
    TweetStream::Client.new.track('Who wants to get demolished? #dbc_c4') do |status|
      tweet = "#{status.text}"
      @opponent_handle = "#{status.user.screen_name}"
      @game_hash = tweet[/#(\w\w\d|\w\d\w|\d\w\w)/]
      break if tweet != ''
    end
  end

  Twitter.configure do |config|
    config.consumer_key = CONSUMER_KEY
    config.consumer_secret = CONSUMER_SECRET
    config.oauth_token = OAUTH_TOKEN
    config.oauth_token_secret = OAUTH_TOKEN_SECRET
  end

  TweetStream.configure do |config|
    config.consumer_key       = CONSUMER_KEY
    config.consumer_secret    = CONSUMER_SECRET
    config.oauth_token        = OAUTH_TOKEN
    config.oauth_token_secret = OAUTH_TOKEN_SECRET
    config.auth_method        = :oauth
  end

  def game_on
    response = "@#{@opponent_handle} Game on! #dbc_c4 #{@game_hash}"
    Twitter.update("#{response}")
  end

  def listen_for_move
    TweetStream::Client.new.track("#dbc_c4 #{@game_hash}") do |status|
      tweet = "#{status.text}"
      @new_board = tweet[/\|.{7}\|.{7}\|.{7}\|.{7}\|.{7}\|.{7}\|/]
      return "win_claimed" if tweet.include "I win!"# match "I won"
      return "tie_claimed" if tweet.include "Draw game."# match "tie"
      return "continue" if tweet != ''
    end
  end

  def send_move(board)
    Twitter.update("#{@opponent_handle} #{board_to_string(board.to_s)} #dbc_c4 #{@game_hash}")
  end

  def end_game
    if move_outcome[0] == "tie"
      tweet("tie", BoardConversion::board_to_string(move_outcome[0]))
      # tweet("tie", convert(move_outcome[1]))
    elsif move_outcome[0] == "win"
      tweet("win", BoardConversion::board_to_string(move_outcome[0]))
      # tweet("win", convert(move_outcome[1]))
    end
  end

  # def reconcile_outcome
  #
  # end


end

Interface.find_twitter_game

#######################################################

# TweetStream::Client.new.track('@puissance_4') do |status|
#   tweet = "#{status.text}"
#   name = "#{status.user.screen_name}"
#   puts "#{name}: #{tweet}"
# end

# TweetStream::Client.new.track('@justinbieber') do |tweet|
#   p tweet
# end


# listen_for_challenge
# game_on
# send_move