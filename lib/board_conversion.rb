module BoardConversion
# class Array

  def board_to_string(board_array)
    str = '|'
    board_array.transpose.reverse.each do |row|
      row.each do |cell|
        cell == "" ? str << "." : str << cell
      end
      str << '|'
    end
    str
  end

  def string_to_board(string)
    string.split('|')[1..-1].map do |row|
      replace_dots(row.split(''))
    end
    .reverse.transpose
  end

  private

  def replace_dots(array)
    array.map { |elt| elt == "." ? "" : elt }
  end

end
