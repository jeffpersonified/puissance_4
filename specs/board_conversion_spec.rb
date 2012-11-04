require_relative '../lib/board_conversion'

describe BoardConversion do
  include BoardConversion

  context "#board_to_string" do
    array = [ ["", "", "", "", "", ""],
              ["", "", "", "", "", ""],
              ["X", "", "", "", "", ""],
              ["O", "X", "O", "", "", ""],
              ["X", "O", "", "", "", ""],
              ["", "", "", "", "", ""],
              ["", "", "", "", "", ""]    ]

    it "converts a board array to a twitter formated string" do
      board_to_string(array).should eq '|.......|.......|.......|...O...|...XO..|..XOX..|'
    end
  end

  context "#string_to_board" do
    string = '|X......|.......|.......|.......|...XO..|..XOX..|'

    it "converts a twitter formated string to a board array" do
      string_to_board(string).should eq [ ["", "", "", "", "", "X"],
                                          ["", "", "", "", "", ""],
                                          ["X", "", "", "", "", ""],
                                          ["O", "X", "", "", "", ""],
                                          ["X", "O", "", "", "", ""],
                                          ["", "", "", "", "", ""],
                                          ["", "", "", "", "", ""]    ]
    end
  end

end