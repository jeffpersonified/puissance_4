class Game
  attr_reader :red_player, :blue_player, :board

  def initialize(p1 = HumanPlayer.new('red'), p2 = HumanPlayer.new('blue'))
    @red_player = p1
    @blue_player = p2
    @board = Board.new
    @turn = 0
  end

  def current_player
    @turn % 2 != 0 ? @red_player : @blue_player
  end

  def winning_combo?
    @board.winning_combo?
  end

  def place_piece(player_id, target_column)
    @board.place_piece(player_id, target_column)
  end

  def move
    pick_col = self.current_player.pick(board)
    @board.place_piece(self.current_player.name, pick_col)
    @turn += 1
  end

end



