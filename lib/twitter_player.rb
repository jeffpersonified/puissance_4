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
    @interface.request(board)
  end

end







