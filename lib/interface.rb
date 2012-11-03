require 'tweetstream'

require_relative 'board_conversion'
require_relative 'game'
require_relative 'player'
require_relative 'human_player'
require_relative 'ai_player'
require_relative 'twitter_player'
require_relative 'board'
require_relative 'errors'


class TwitterInterface
  include BoardConversion

  establish_connection
  listen("demolished...")
  tweet("game on")

  def initialize
    # game = Game.new(HumanPlayer.new('Jeffrey'), HumanPlayer.new('Matt'))
    game = Game.new(TwitterPlayer.new(1,self), AIPlayer.new(2))
  end

  def run_game
      puts game.board
      move_outcome = game.move

    while move_outcome[0] == "continue"
      move_outcome = game.move
    end
  end


  if move_outcome[0] == "tie"
    tweet("tie", BoardConversion::board_to_string(board))
    # tweet("tie", convert(move_outcome[1]))
  elsif move_outcome[0] == "win"
    tweet("win", BoardConversion::board_to_string(board))
    # tweet("win", convert(move_outcome[1]))
  end

  def request(board)
    tweet(board + "message")
    listen("opponent_name")
    BoardConversion::string_to_board(parse(tweet))
    # the player will compare this array with the board.cells
    # and return the # of the updated column to the game
  end


  private
  def establish_connection
    # twitter connect keys and tokens
  end

  def listen(keywords)
    # via the streaming API, listen to tweets that mention the keywords
  end

  def tweet("game on")
    # reply to the user who challenge with "Game on..."
  end

  def parse(tweet)
    # retrieve the board out of the tweet
  end

  def tweet("board")
    BoardConversion::board_to_string(board)
    # send tweet
  end
end

TwitterInterface.new()
#######################################################

require 'tweetstream'
require 'twitter'
#
Twitter.configure do |config|
  config.consumer_key = 'sshDSUlCHSqhL8p6FFbww'
  config.consumer_secret = '2GCoPMLc6aA0flYbEtRGCQT5LhxwBKFKA3g6y0xo4'
  config.oauth_token = '921596012-eflaRGrBnrkq65CyfMW6JQL5yytv61Xror2GDH5V'
  config.oauth_token_secret = 'i7OaJmL1bMAUdRaDllVIHT1tlhPoBMm66SaIqlT3s'
end

TweetStream.configure do |config|
  config.consumer_key       = 'sshDSUlCHSqhL8p6FFbww'
  config.consumer_secret    = '2GCoPMLc6aA0flYbEtRGCQT5LhxwBKFKA3g6y0xo4'
  config.oauth_token        = '921596012-eflaRGrBnrkq65CyfMW6JQL5yytv61Xror2GDH5V'
  config.oauth_token_secret = 'i7OaJmL1bMAUdRaDllVIHT1tlhPoBMm66SaIqlT3s'
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