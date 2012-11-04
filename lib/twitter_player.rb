require_relative './player'

class TwitterPlayer < Player
  # attr_accessor :name
  #
  # def initialize(name = "anonymous")
  #   self.name = name
  # end
  #
  # def pick(board)
  #   raise NotImplementedError, "Implement this in a subclass!"
  # end
  #
  # def to_s
  #   name
  # end
  #
  # def valid_input?(input)
  #   input.class == Fixnum && input < 8 && input > 0
  # end

  def self.start_up(name, interface)
    self.new(name)
    interface(interface)
  end

  def interface=(interface)
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







