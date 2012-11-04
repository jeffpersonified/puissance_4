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

  attr_accessor :board, :game

  def initialize
    @game = Game.new(AIPlayer.new('O'), TwitterPlayer.new('X', self))
    @board = @game.board.cells
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
    Twitter.update("#{@opponent_handle} #{board_to_string(board)} #dbc_c4 #{@game_hash}")
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
end