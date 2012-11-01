class Board
  attr_reader :cells

  def initialize
    @cells = Array.new(7) { Array.new(6, "") }
  end

  def place(color, placement)
    raise ColumnFullError if column_full?(placement)
    column = column(placement)
    column[index_first_empty(column)] = color
  end

  private
    def column num
      @cells[num-1]
    end

    def index_first_empty(array)
      array.each_with_index do |element, index|
        return index if element == ""
      end
    end

    def column_full? num
      column(num).last != ""
    end

end


class ColumnFullError < StandardError
  def message
    "Sorry, the column is full"
  end
end

# [ [ ,  ,  ,  ,  , ],
#   [ ,  ,  ,  ,  , ],
#   [ ,  ,  ,  ,  , ],
#   [ ,  ,  ,  ,  , ],
#   [ ,  ,  ,  ,  , ],
#   [ ,  ,  ,  ,  , ],
#   [ ,  ,  ,  ,  , ] ]