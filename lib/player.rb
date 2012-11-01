class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def pick
    rand(7) + 1
  end

end