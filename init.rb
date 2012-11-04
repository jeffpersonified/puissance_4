require_relative './lib/interface'

twitter_game = Interface.new
twitter_game.listen_for_challenge
twitter_game.game_on

while true
  twitter_game.send_move(twitter_game.board)
  twitter_game.listen_for_move
end

