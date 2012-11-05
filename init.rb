require_relative './lib/interface'

twitter_game = Interface.find_game_human

# while true
#   twitter_game.send_move(twitter_game.board)
#   twitter_game.listen_for_move
# end

# would you like to play on the console or on twitter?
# response
# Find a game or start a game
# if want to start a game,
#   send tweet with demolished
#   wait for game on and save user screenname to play against
#
#   contingent on intializing a different type of game