require_relative './player'
class SmartAIPlayer < Player

  def pick(board)
    return 1
    check_horizontal_win(board)
  end

  def check_horizontal_win(board)
    board.cells.each_index do |y|
      1.upto(4) do |x|
        # Check if there are three of our marker in a row
        t = board.cells[y].slice(x, x+2).uniq
        if t.length == 1 and t[0] == self.name


        end
      end
    end
  end


end