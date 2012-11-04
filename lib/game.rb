class Game
  attr_reader :board

  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
    @board = Board.new
    @turn = 1
  end

  def current_player
    @turn % 2 != 0 ? @p1 : @p2
  end

  def winning_combo?
    @board.winning_combo?
  end

  def place_piece(player_id, target_column)
    @board.place_piece(player_id, target_column)
  end

  def full_board?
    @turn >= 42
  end

  def move
    pick_col = self.current_player.pick(@board)
    @board.place_piece(self.current_player.symbol, pick_col)
    @turn += 1
    if winning_combo?
      return ["win", @board]
    elsif full_board?
      return ["tie", @board]
    else
      return ["continue",nil]
    end
  end

end



