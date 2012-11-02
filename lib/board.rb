require_relative 'errors'

class Board
  attr_reader :cells

  def initialize
    @width = 7
    @height = 6
    @cells = Array.new(@width) { Array.new(@height, "") }
    @latest_play = nil
  end

  def place_piece(player_id, placement)
    raise ColumnFullError if column_full?(placement)
    drop(player_id, placement)
    update_latest_play(placement)
    true
  end

  def winning_combo?
    raise BoardEmptyError if @latest_play.nil?
    row = extract_row(@latest_play[1])
    column = extract_column(@latest_play[0])
    diag1 = diagonal(@latest_play[0], @latest_play[1])[0]
    diag2 = diagonal(@latest_play[0], @latest_play[1])[1]
    groups = [row, column, diag1, diag2]
    groups.any? { |group| connect_four?(group) }
  end

  def to_s
    @cells.transpose.reverse.each_with_index do |row, index|
      row.each do |cell|
        printf("| %-2s", cell)
      end
      print "|\n"
    end
  end

  private
    def extract_column(num)
      @cells[num-1]
    end

    def extract_row(num)
      @cells.transpose[num-1]
    end

    def column_full?(num)
      extract_column(num).last != ""
    end

    def index_first_empty(placement)
      extract_column(placement).each_with_index do |element, index|
        return index if element == ""
      end
      return @height
    end

    def drop(player_id, placement)
      @cells[placement-1][index_first_empty(placement)] = player_id
    end

    def update_latest_play(placement)
      @latest_play = [placement, index_first_empty(placement)]
    end

    def connect_four?(group)
      group.join.include?("1111") || group.join.include?("2222")
    end

    def diagonal(x,y)
      first = @cells.diagonal_left_to_right(x,y)
      second = @cells.map(&:reverse).diagonal_right_to_left(x,y)
      [first, second]
    end

end

class Array
  def diagonal_left_to_right(x,y)
    diagonal_array = []
    edge_distance = [x,y].min
    x0, y0 = x - edge_distance, y - edge_distance
    x0 < y0 ? d = 6 - y0 : d = 7 - x0
    (0...d).each do |i|
      diagonal_array << self[x0+i][y0+i]
    end
    diagonal_array
  end

  def diagonal_right_to_left(x,y)
    self.reverse.map(&:reverse).diagonal_left_to_right(6-x,y)
  end

end


#################################################
### LITTLE SCRIPT TO TEST QUICKLY IN THE TERMINAL
#################################################

# board = Board.new
# 5.times do
#   [1,2].each { |player| board.place_piece(player,rand(0...6)) }
# end
# puts board

# test the addition of a piece in a full column
# 7.times do
#   board.place_piece(1,1)
# end
# puts board