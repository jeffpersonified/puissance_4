# STRATEGY
# 1) we look for winning opportunities
# 2) if none, we look for losing threats
# 3) if none, we play a random column
# 4) before sending the move, we check if we're not opening a winning opportunity to our opponent 

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

  private
  
    def middle_column_open?(board)
      board.cells[3][0] == ""
    end

    def column_to_win(board)
      # for each column, we simulate adding our piece there
      # if it leads to a winning combo, we return the index
      # otherwise we return FALSE
      # we discard the changes after 
      (0...board.width).each do |index|
        height = board.index_first_empty(index + 1)
        board.place_piece(self.symbol, index + 1)
        if board.winning_combo?
          board.cells[index][height] = ""
          return index + 1
        end
        board.cells[index][height] = "" # remove piece added
      end
      false
    end

    def column_to_defend(board)
      (0...board.width).each_index do |index|
        height = board.index_first_empty(index + 1)
        board.place_piece(other_player_symbol, index + 1)
        if board.winning_combo?
          board.cells[index][height] = ""
          return index + 1
        end
        board.cells[index][height] = ""
      end
      false
    end
    
    def other_player_symbol
      self.symbol == 'O' ? 'X' : 'O'
    end

end

