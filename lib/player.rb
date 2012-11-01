class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def pick(board) # This method needs a system to gain an actual choice from the user via the UI.
    @current_board = board
    rand(7) + 1
  end

  def current_board
    @current_board
  end

end