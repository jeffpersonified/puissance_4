require 'pry'
require_relative './player'
require_relative './board'

class SmartAIPlayer < Player

  def pick(board)
    p column_to_win(board)

  end


  def column_to_win(board)
    board.cells.each_with_index do |row, index|
      # add piece
      height = board.index_first_empty(index + 1)
      board.place_piece(self.name, index + 1)
      if board.winning_combo?
        return index + 1
      end
      # remove piece added
      board.cells[index][height] = ""
    end
  end

  # def column_to_defend
  #   board.cells.each_with_index do |row, index|
  #     # add piece
  #     height = board.index_first_empty(index + 1)
  #     board.place_piece(self.name, index + 1)
  #     if board.winning_combo?
  #       return index + 1
  #     end
  #     # remove piece added
  #     board.cells[index][height] = ""
  #   end
  #
  # end


end

# board = Board.new
# board.place_piece(1,5)
# board.place_piece(1,5)
# board.place_piece(1,5)
#
#
# player = SmartAIPlayer.new(1)
# player.column_to_win(board)
#
#
# player.pick(board)