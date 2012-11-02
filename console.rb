require_relative 'lib/game'
require_relative 'lib/player'
require_relative './lib/human_player'
require_relative './lib/ai_player'

# game = Game.new(HumanPlayer.new('Jeffrey'), HumanPlayer.new('Matt'))
game = Game.new(HumanPlayer.new('Jeffrey'), AIPlayer.new('the dude'))

while true

  # begin
    game.move
  # rescue Exception => e
  #    puts "something went wrong!"
  #    p e
  #  end


  if game.winning_combo?
    puts "#{game.current_player} just won!  congrats."
    break
  end
end

