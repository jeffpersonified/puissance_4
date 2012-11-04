require_relative './player'
require_relative './board'

class SmartAIPlayer < Player

  def pick(board)
    if column_to_win(board) != false
      puts "winning move!"
      column_to_win(board)
    elsif column_to_defend(board) != false
      puts "must defend"
      column_to_defend(board)
    elsif middle_column_open?(board)
      puts "drop in middle"
      4
    else
      puts "random move!"
      rand(1..7)
    end

  end

  def middle_column_open?(board)
    board.cells[3][0] == ""
  end

  def column_to_win(board)
    board.cells.each_index do |index|
      height = board.index_first_empty(index + 1) # add piece
      board.place_piece(self.name.to_i, index + 1)
      if board.winning_combo?
        board.cells[index][height] = ""
        return index + 1
      end
      board.cells[index][height] = "" # remove piece added
    end
    false
  end

  def column_to_defend(board)
    board.cells.each_index do |index|
      height = board.index_first_empty(index + 1) # add piece
      board.place_piece(2, index + 1)
      # the '2' needs to be the opponent's name

      if board.winning_combo?
        board.cells[index][height] = ""
        return index + 1
      end
      board.cells[index][height] = "" # remove piece added
    end
    false
  end


end

board = Board.new
player = SmartAIPlayer.new(1)
# board.place_piece(1,3)
# board.place_piece(1,3)
# board.place_piece(1,3)


# p player.column_to_win(board)


board.place_piece(2,1)
board.place_piece(2,1)
board.place_piece(2,1)

p player.pick(board)

# board.place_piece(player.name.to_i, player.pick(board))
# p board


