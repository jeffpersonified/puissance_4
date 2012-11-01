class ColumnFullError < StandardError
  def message
    "Sorry, the column is full"
  end
end