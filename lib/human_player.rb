require_relative './player'

class HumanPlayer < Player
  attr_accessor :interface

  def initialize(symbol, interface = :console) # could change to twitter, sms, phone, etc.
    super(symbol)
    @interface = interface
  end

  def pick(board)
    puts "Player #{self.symbol}!  It's your turn.  Pick a number 1..7"
    selection = gets.chomp.to_i
    while !valid_input?(selection)
      puts "That input is not valid, please enter a number between 1 and 7."
      selection = gets.chomp.to_i
    end
    selection
  end

end