require './column_full_error.rb'

class Board
  attr_reader :cells

  def initialize
    @cells = Array.new(7) { Array.new(6, "") }
  end

  def place_piece(color, placement)
    raise ColumnFullError if column_full?(placement)
    column = column(placement)
    column[index_first_empty(column)] = color
    true
  end

  def to_s
    @cells.transpose.reverse.each_with_index do |row, index|
      row.each do |cell|
        printf("%-3s", cell)
      end
      puts
    end
  end

  # when a player places a piece in column x
  # we compute y buy looking at the index of the first empty cell - 1
  # we get the coordinates (x,y)
  # we check 4 groups : the column(x), the row(y) and the 2 diagonals linked to the (x,y) piece
  # we run #connect_four on them
  # if we have at least one "true", we return "true" to the Game object

  private
    def column num
      @cells[num-1]
    end

    def column_full? num
      column(num).last != ""
    end

    def index_first_empty(array)
      array.each_with_index do |element, index|
        return index if element == ""
      end
    end
end


#################################################
### LITTLE SCRIPT TO TEST QUICKLY IN THE TERMINAL
#################################################

board = Board.new
5.times do
  [1,2].each { |player| board.place_piece(player,rand(0...6))  }
end
puts board

# test the addition of a piece in a full column
# 7.times do
#   board.place_piece(1,1)
# end
# puts board

#####################
### IDEAS FOR GROUPS
#####################

# @group_rows = { :row_1 => [[0,0],[1,0],[2,0],[3,0],[4,0],[5,0]],
#                 :row_2 => [[0,1],[1,1],[2,1],[3,1],[4,1],[5,1]],
#                 #...
#                 :row_6 => [[0,5],[1,5],[2,5],[3,5],[4,5],[5,5]]
#               }
#
# @group_columns = { :column_1 => [[0,0],[0,1],[0,2],[0,3],[0,4],[0,5]],
#                    :column_2 => [[1,0],[1,1],[1,2],[1,3],[1,4],[1,5]],
#                    #...
#                    :column_6 => [[5,0],[5,1],[5,2],[5,3],[5,4],[5,5]]
#               }
#
# @group_diagonals_1 = { :diagonal_1 => [[0,2],[1,3],[2,4],[3,5]],
#                        :diagonal_2 => [[0,1],[1,2],[2,3],[3,4],[4,5]],
#                       :diagonal_3 => [[0,0],[1,1],[2,2],[3,3],[4,4],[5,5]],
#                       #...
#               }
#
# @group_diagonals_2 = { :diagonal_1 => [[0,2],[1,3],[2,4],[3,5]],
#                        :diagonal_2 => [[0,1],[1,2],[2,3],[3,4],[4,5]],
#                        :diagonal_3 => [[0,0],[1,1],[2,2],[3,3],[4,4],[5,5]],
#                        #...
#               }