require_relative './player'

class TwitterPlayer < Player

  def initialize(symbol, interface)
    super(symbol)
    @interface = interface
  end

  def pick(board)
    puts "board.cells: #{board.cells}"
    updated_board = @interface.request(board.cells)
    puts "Updated board: #{updated_board}"
    find_difference(board, updated_board)
  end

  private

  def find_difference(board, updated_board)
    index = 0
    (1..7).each do |i|
      index = i if board.cells[i] != updated_board[i]
    end
    index + 1
  end

end







