# frozen_string_literal: true
# require './board'

class Game
  attr_accessor :board
  attr_reader :player1
  attr_reader :player2
  attr_reader :player_marker
  attr_accessor :player_turn
  attr_reader :last_played_pos
  attr_reader :last_played_char
  attr_reader :winning_ranges

  def initialize(board:, player1:, player2:)
    @player1 = player1
    @player2 = player2
    @board = board
    @player_marker = { 'x' => player1, 'o' => player2 }
    @last_played_pos = []
  end

  def write_onboard(player, pos)
    raise 'Only numbers in the mentioned range are allowed' if !pos.is_a? Integer
    @last_played_char = @player_marker.invert[player]
    board.write_onboard(last_played_char, pos)
    last_played_pos[0] = pos
    last_played_pos[1] = @board.grid[@last_played_pos[0]].length - 1
    # binding.pry
    @player_turn = @player_marker.reject { |k, v| v == player }.values.first
    # binding.pry
    build_winning_ranges
  end

  def build_winning_ranges
    @last_played_pos[1] = @board.grid[@last_played_pos[0]].length - 1
    @winning_ranges= []
    last_played_pos[0] > 3 ? x = Array(last_played_pos[0] - 3..6) : x = Array(0 ..last_played_pos[0] + 3)
    last_played_pos[1] > 3 ? y = Array(last_played_pos[1] - 3..6) : y = Array(0 ..last_played_pos[1] + 3)
    puts y
    winning_ranges << x
    winning_ranges << y
    winning_ranges << x.product(y).select {|arr| arr[0]-arr[1] == last_played_pos[0] - last_played_pos[1]}
    winning_ranges << x.product(y).select {|arr| arr[0]+arr[1] == last_played_pos[0] + last_played_pos[1]}
    # binding.pry
  end

  def get_winner
    return nil if last_played_pos[0] == nil
    result = []
    # binding.pry
    result << horizontal_pattern
    result << vertical_pattern

    # binding.pry
    result << diagonal1_pattern
    result << diagonal2_pattern
    array = result.find { |arr| arr == ['x']*4 || arr == ['o']*4}
    if array
      # binding.pry
      # if array exists and is not full of zeros, then there is a winner
      @player_marker[array.uniq.first]
    else
      # else the game is draw
      # 'The game is draw, no one wins!'
      nil
    end
  end

  def horizontal_pattern
    # @last_played_pos[1] = @board.grid[@last_played_pos[0]].length - 1

    # binding.pry
    horizontal=[]

    # puts @winning_ranges[2]
    # binding.pry
    i = 0
    # iterator = x.zip(y)
    # (x.length + y.length).times{array << []}
    # binding.pry
    while i < winning_ranges[0].length
      # binding.pry
      if @board.grid[winning_ranges[0][i]][last_played_pos[1]] != nil && @board.grid[winning_ranges[0][i]][last_played_pos[1]] == last_played_char
        horizontal << @board.grid[winning_ranges[0][i]][last_played_pos[1]]
        # binding.pry
        break if horizontal.length == 4
      else
        horizontal = []
      end
      # binding.pry
      i += 1
      # binding.pry
    end
    # binding.pry
    return horizontal if horizontal == [last_played_char,last_played_char,last_played_char,last_played_char]
    nil
  end

  def vertical_pattern
    @last_played_pos[1] = @board.grid[@last_played_pos[0]].length - 1

    # binding.pry
    vertical=[]
    # last_played_pos[0] > 3 ? x = Array(last_played_pos[0] - 3..6) : x = Array(0 ..last_played_pos[0] + 3)
    # last_played_pos[1] > 3 ? y = Array(last_played_pos[1] - 3..6) : y = Array(0 ..last_played_pos[1] + 3)
    # @winning_ranges[2] = x.product(y).select {|arr| arr[0]-arr[1] == last_played_pos[0] - last_played_pos[1]}
    # @winning_ranges[3] = x.product(y).select {|arr| arr[0]+arr[1] == last_played_pos[0] + last_played_pos[1]}
    # puts @winning_ranges[2]
    # binding.pry
    j = 0
    # iterator = x.zip(y)
    # (x.length + y.length).times{array << []}
    # binding.pry
    # puts (winning_ranges[1] == y)
    # puts winning_ranges[1]
    # puts y

    # while j < y.length do
    # while j < y.length do
    #   if @board.grid[last_played_pos[0]][y[j]] != nil && @board.grid[last_played_pos[0]][y[j]] == last_played_char
    #     vertical << @board.grid[last_played_pos[0]][y[j]]
    #     break if vertical.length == 4
    #   else
    #     vertical = []
    #   end
    #   j += 1
    # end
    while j < winning_ranges[1].length do
      if @board.grid[last_played_pos[0]][winning_ranges[1][j]] != nil && @board.grid[last_played_pos[0]][winning_ranges[1][j]] == last_played_char
        vertical << @board.grid[last_played_pos[0]][winning_ranges[1][j]]
        break if vertical.length == 4
      else
        vertical = []
      end
      j += 1
    end
    # binding.pry
    return vertical if vertical == [last_played_char,last_played_char,last_played_char,last_played_char]
    nil
  end

  def diagonal1_pattern
    x_res=[]
    # check for the data in the diagonal /
    k = 0
    x_diag,y_diag = [],[]
    winning_ranges[2].each{|arr| x_diag << arr[0]; y_diag << arr[1] }
    while k < x_diag.length do
      # binding.pry
      if @board.grid[x_diag[k]][y_diag[k]] != nil && @board.grid[x_diag[k]][y_diag[k]] == last_played_char
        x_res << @board.grid[x_diag[k]][y_diag[k]]
        break if x_res.length == 4
      else
        x_res = []
      end
      k += 1
    end
    # binding.pry
    return x_res if x_res == [last_played_char,last_played_char,last_played_char,last_played_char]
    nil
  end

  def diagonal2_pattern
    y_res=[]
    # check for the data in the diagonal \
    k = 0
    x_diag,y_diag = [],[]
    winning_ranges[3].each{|arr| x_diag << arr[0]; y_diag << arr[1] }
    while k < x_diag.length do
      # binding.pry
      if @board.grid[x_diag[k]][y_diag[k]] != nil && @board.grid[x_diag[k]][y_diag[k]] == last_played_char
        y_res << @board.grid[x_diag[k]][y_diag[k]]
        break if y_res.length == 4
      else
        y_res = []
      end
      # binding.pry
      k += 1
    end
    # binding.pry
    return y_res if y_res == [last_played_char,last_played_char,last_played_char,last_played_char]
    nil
  end
end
