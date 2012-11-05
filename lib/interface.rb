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
    self.start
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

  def start
    listen_for_challenge
    game_on
    run_game
  end

  def run_game
    move_outcome = @game.move
    while move_outcome[0] == "continue"
      puts "move_outcome: #{move_outcome[0]}"
      move_outcome = @game.move
    end
    end_game(move_outcome)
  end

  def listen_for_challenge
    TweetStream::Client.new.track('Who wants to get demolished? #dbc_c5') do |status|
      tweet = "#{status.text}"
      @opponent_handle = "@#{status.user.screen_name}"
      @game_hash = tweet[/#(\w\w\d|\w\d\w|\d\w\w)/]
      puts @game_hash
      break if tweet != ''
    end
  end

  def game_on
    response = "#{@opponent_handle} Game on! #dbc_c5 #{@game_hash}"
    Twitter.update("#{response}")
  end

  def send_move(board)
    Twitter.update("#{@opponent_handle} #{board_to_string(board)} #dbc_c5 #{@game_hash}")
  end

  def end_game(move_outcome)
    if move_outcome[0] == "tie"
      Twitter.update("Draw game. Play again?", BoardConversion::board_to_string(move_outcome[1]))
    elsif move_outcome[0] == "win"
      Twitter.update("I win! Good game.", BoardConversion::board_to_string(move_outcome[1]))
    end
  end

  def request(board)
    send_move(board)
    listen_for_move
    string_to_board(@new_board)
  end

  def listen_for_move
    TweetStream::Client.new.track("#dbc_c5 #{@game_hash}") do |status|
      tweet = "#{status.text}"
      @new_board = tweet[/\|.{7}\|.{7}\|.{7}\|.{7}\|.{7}\|.{7}\|/]
      return "win_claimed" if tweet.include?("I win!")# match "I won"
      return "tie_claimed" if tweet.include?("Draw game.")# match "tie"
      return
    end
  end

end