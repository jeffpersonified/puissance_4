class ColumnFullError < StandardError
  def message
    "Sorry, the column is full"
  end

end


class Board
  def place_piece(id, target)
    puts "player #{id} just placed a piece in column #{target}"
  end

  def winning_combo?
    return [false,false,false,false,false,false,false,false,true].sample(1)[0]
  end

end



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
     puts "it is turn: #{@turn}"
    @board.place_piece(self.current_player.name, self.current_player.pick(board))
    @turn += 1
  end

end







