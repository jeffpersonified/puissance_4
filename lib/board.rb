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
    diag1 = @cells.diagonal_left_to_right(@latest_play[1]-1, @latest_play[0]-1)
    diag2 = @cells.diagonal_right_to_left(@latest_play[1]-1, @latest_play[0]-1)
    [row, column, diag1, diag2].any? { |group| connect_four?(group) }
  end

  def to_s
    @cells.transpose.reverse.each_with_index do |row, index|
      row.each { |cell| printf("| %-2s", cell) }
      print "|\n"
    end
  end

  # private
    def extract_column(num)
      @cells[num - 1]
    end

    def extract_row(num)
      @cells.transpose[num - 1]
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
      str = group.join
      str.include?("XXXX") || str.include?("OOOO")
    end

end

class Array

  def diagonal_left_to_right(col, row)
    min = [row, col].min
    row_i, col_i = row - min, col - min

    n_cols = self.length
    n_rows = self.first.length

    d_length = [ n_cols - col_i,
                 n_rows - row_i ].min

    (0...d_length).map do |d|
      self[col_i + d][row_i + d]
    end
  end

  def diagonal_right_to_left(col, row)
    self.map(&:reverse).diagonal_left_to_right(col, self.first.length - 1 - row)
  end

end

