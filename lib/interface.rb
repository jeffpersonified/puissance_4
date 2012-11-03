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