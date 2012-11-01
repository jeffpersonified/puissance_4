class Game
  attr_reader :red_player, :blue_player, :board

  def initialize
    @red_player = Player.new('red')
    @blue_player = Player.new('blue')
    @turn = 1
    @board = Board.new
  end

  def insertion_target_column
    current_player.pick
  end

  def current_player
    @turn % 2 != 0 ? @red_player : @blue_player
  end

  def winning_combo?
    @board.winning_combo?
  end

  def is_full?
    @board.is_full?
  end

  def place_piece(player_id, insertion_target_column)
    @board.place_piece(player_id, insertion_target_column)
  end

end




class Board
end

class ColumnFullError < StandardError
  def message
    "Sorry, the column is full"
  end

end
