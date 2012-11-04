class Player
  attr_accessor :number

  def initialize(number, interface = :console)
    self.number = number
    self.interface = interface
  end

  def pick(board)
    raise NotImplementedError, "Implement this in a subclass!"
  end

  # def to_s
  #   name
  # end

  def valid_input?(input)
    input.class == Fixnum && input < 8 && input > 0
  end

end







