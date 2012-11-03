class Player
  attr_accessor :name

  def initialize(name = "anonymous")
    self.name = name
  end

  def pick(board)
    raise NotImplementedError, "Implement this in a subclass!"
  end

  def to_s
    name
  end

  def valid_input?(input)
    input.class == Fixnum && input < 8 && input > 0
  end

end







