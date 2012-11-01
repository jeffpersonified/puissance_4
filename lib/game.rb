class Game
  attr_reader :red_player, :blue_player

  def initialize
    @red_player = {:color => "red"}
    @blue_player = {:color => "blue"}
  end

  def insertion_target_column
    current_player.pick
  end

  def current_player
    turn % 2 = 0 ? @red_player : @blue_player
  end


end