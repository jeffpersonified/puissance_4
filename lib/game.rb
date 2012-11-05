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
    p @board
    p self.current_player
    p self.current_player.class
    pick_col = self.current_player.pick(@board)
    p pick_col
    @board.place_piece(self.current_player.symbol, pick_col)
    p @board
    @turn += 1
    if winning_combo?
      return ["win", @board.cells]
    elsif full_board?
      return ["tie", @board.cells]
    else
      return ["continue"]
    end
  end

end



