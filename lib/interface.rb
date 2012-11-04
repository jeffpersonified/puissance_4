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

  establish_connection
  listen("demolished...")
  tweet("game on")

  def initialize
    # game = Game.new(HumanPlayer.new('Jeffrey'), HumanPlayer.new('Matt'))
    game = Game.new(TwitterPlayer.new(1,self), HumanPlayer.new(2))
  end

  def self.look_for_and_play_twitter_game
    listen_for_challenge
    game_on
    self.new
  end

  def run_game
      move_outcome = game.move

    while move_outcome[0] == "continue"
      move_outcome = game.move
    end
    reconcile_outcome(move_outcome)
    end_condition(move_outcome)
  end

  def request(board)
    send_move()
    @claimed_outcome = listen_for_move
    BoardConversion::string_to_board(@new_board)
  end

  private

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

  def listen_for_challenge
    TweetStream::Client.new.track('Who wants to get demolished? #dbc_c4') do |status|
      tweet = "#{status.text}"
      @opponent_handle = "#{status.user.screen_name}"
      @game_hash = tweet[/#(\w\w\d|\w\d\w|\d\w\w)/]
      break if tweet != ''
    end
  end

  def game_on
    response = "@#{@opponent_handle} Game on! #dbc_c4 #{@game_hash}"
    Twitter.update("#{response}")
  end

  def end_condition
    if move_outcome[0] == "tie"
      tweet("tie", BoardConversion::board_to_string(move_outcome[0]))
      # tweet("tie", convert(move_outcome[1]))
    elsif move_outcome[0] == "win"
      tweet("win", BoardConversion::board_to_string(move_outcome[0]))
      # tweet("win", convert(move_outcome[1]))
    end
  end



  def reconcile_outcome

  end


end

Interface.look_for_and_play_twitter_game

#######################################################






def send_move(board)
  Twitter.update("#{@opponent_handle} #{board.board_to_string} #dbc_c4 #{@game_hash}")
end

def listen_for_move
  TweetStream::Client.new.track("#dbc_c4 #{@game_hash}") do |status|
    tweet = "#{status.text}"
    @new_board = tweet[/\|.{7}\|.{7}\|.{7}\|.{7}\|.{7}\|.{7}\|/]
    return "win_claimed" if tweet.include "I win!"# match "I won"
    return "tie_claimed" if tweet.include "Draw game."# match "tie"
    break if tweet != ''
  end
end


# TweetStream::Client.new.track('@puissance_4') do |status|
#   tweet = "#{status.text}"
#   name = "#{status.user.screen_name}"
#   puts "#{name}: #{tweet}"
# end

# TweetStream::Client.new.track('@justinbieber') do |tweet|
#   p tweet
# end


listen_for_challenge
game_on
send_move