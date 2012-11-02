require_relative './player'

class AIPlayer < Player

  def pick(board)
    col = rand(1..7)
    puts "The computer just played in column #{col}"
    col
  end
end