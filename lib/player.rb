class Player
  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def pick(board)
    raise NotImplementedError, "Implement this in a subclass!"
  end

  def to_s
    symbol
  end

  def valid_input?(input)
    input.class == Fixnum && input < 8 && input > 0
  end

end







