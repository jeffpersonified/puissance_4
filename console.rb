require_relative 'lib/game'
require_relative 'lib/player'
require_relative './lib/human_player'
require_relative './lib/ai_player'
require_relative './lib/board'
require_relative './lib/errors'


# game = Game.new(HumanPlayer.new('Jeffrey'), HumanPlayer.new('Matt'))
game = Game.new(HumanPlayer.new(1), AIPlayer.new(2))

while true

  begin
    puts game.board
    game.move
  rescue Exception => e
    p e.message
  end

  if game.winning_combo? || game.full_board?
    puts game.board
    break
  end
end

