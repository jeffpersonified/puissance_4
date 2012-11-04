require_relative './player'

class TwitterPlayer < Player

  def initialize(symbol, interface)
    super(symbol)
    @interface = interface
  end

  def pick(board)
    updated_board = @interface.request(board)
    find_difference(board, updated_board)
  end

  private

  def find_difference(array1, array2)
    index = 0
    (1..7).each do |i|
      index = i if board[i] != updated_board[i]
    end
    index + 1
  end

end







