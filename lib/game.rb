class Game
  attr_reader :red_player, :blue_player, :board

  def initialize(p1 = HumanPlayer.new('red'), p2 = HumanPlayer.new('blue'))
    @red_player = p1
    @blue_player = p2
    @board = Board.new
    @turn = 1
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

  def full_board?
    @turn >= 42
  end

  def move
    pick_col = self.current_player.pick(board)
    @board.place_piece(self.current_player.name, pick_col)
    if winning_combo?
      puts "Player #{current_player.name} wins!"
      return
    elsif full_board?
      puts "Tied game!"
      return
    end
    @turn += 1
  end

end



