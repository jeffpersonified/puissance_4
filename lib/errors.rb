class ColumnFullError < StandardError
  def message
    "Oops, the column is full"
  end
end

class BoardEmptyError < StandardError
  def message
    "Nope, you must play in order to check for a winning combo"
  end
end