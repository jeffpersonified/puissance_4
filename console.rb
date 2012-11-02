require_relative 'lib/game'
require_relative 'lib/player'
require_relative './lib/human_player'
require_relative './lib/ai_player'
require_relative './lib/board'
require_relative './lib/errors'


# game = Game.new(HumanPlayer.new('Jeffrey'), HumanPlayer.new('Matt'))
game = Game.new(AIPlayer.new(1), HumanPlayer.new(2))

while true

  begin
  puts game.board
  game.move
  rescue Exception => e
    puts "That column is full, pick another!"
    p e
  end


  if game.winning_combo?
    puts "Player #{game.current_player.name} just won! Congrats."
    puts "This is the final board:"
    puts game.board
    break
  end
end

