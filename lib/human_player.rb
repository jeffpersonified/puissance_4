require_relative './player'

class HumanPlayer < Player
  attr_accessor :interface

  def initialize(name, interface = :console) # could change to twitter, sms, phone, etc.
    super(name)
    self.interface = interface
  end

  def pick(board)
    puts board
    selection = gets.chomp.to_i
    while !valid_input?(selection)
      puts "That input is not valid, please enter a number between 1 and 7."
      selection = gets.chomp.to_i
    end
    selection
  end

end