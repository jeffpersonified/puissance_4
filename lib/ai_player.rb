require_relative './player'

class AIPlayer < Player

  def pick(board)
    rand(1..7)
  end
end