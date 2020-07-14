# frozen_string_literal: true
# require './board'

class Game
  attr_accessor :board
  attr_reader :player1
  attr_reader :player2
  attr_reader :player_marker
  attr_accessor :player_turn
  attr_reader :last_played_x
  attr_reader :last_played_y
  attr_reader :char
  attr_reader :diagonal1
  attr_reader :diagonal2

  def initialize(board:, player1:, player2:)
    @player1 = player1
    @player2 = player2
    @board = board
    @player_marker = { 'x' => player1, 'o' => player2 }
  end

  def write_onboard(player, pos)
    @char = @player_marker.invert[player]
    board.write_onboard(char, pos)
    @last_played_x = pos
    @last_played_y = @board.grid[@last_played_x].length - 1
    # binding.pry
    @player_turn = @player_marker.reject { |k, v| v == player }.values.first
    # binding.pry
  end

  def get_winner
    return nil if last_played_x == nil
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
    @last_played_y = @board.grid[@last_played_x].length - 1

    # binding.pry
    horizontal=[]
    last_played_x > 3 ? x = Array(last_played_x - 3..6) : x = Array(0 ..last_played_x + 3)
    last_played_y > 3 ? y = Array(last_played_y - 3..6) : y = Array(0 ..last_played_y + 3)
    @diagonal1 = x.product(y).select {|arr| arr[0]-arr[1] == last_played_x - last_played_y}
    @diagonal2 = x.product(y).select {|arr| arr[0]+arr[1] == last_played_x + last_played_y}
    # puts @diagonal1
    # binding.pry
    i = 0
    # iterator = x.zip(y)
    # (x.length + y.length).times{array << []}
    # binding.pry
    while i < x.length
      # binding.pry
      if @board.grid[x[i]][last_played_y] != nil && @board.grid[x[i]][last_played_y] == char
        horizontal << @board.grid[x[i]][last_played_y]
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
    return horizontal if horizontal == [char,char,char,char]
    nil
  end

  def vertical_pattern
    @last_played_y = @board.grid[@last_played_x].length - 1

    # binding.pry
    vertical=[]
    last_played_x > 3 ? x = Array(last_played_x - 3..6) : x = Array(0 ..last_played_x + 3)
    last_played_y > 3 ? y = Array(last_played_y - 3..6) : y = Array(0 ..last_played_y + 3)
    @diagonal1 = x.product(y).select {|arr| arr[0]-arr[1] == last_played_x - last_played_y}
    @diagonal2 = x.product(y).select {|arr| arr[0]+arr[1] == last_played_x + last_played_y}
    # puts @diagonal1
    # binding.pry
    j = 0
    # iterator = x.zip(y)
    # (x.length + y.length).times{array << []}
    # binding.pry

    while j < y.length do
      if @board.grid[last_played_x][y[j]] != nil && @board.grid[last_played_x][y[j]] == char
        vertical << @board.grid[last_played_x][y[j]]
        break if vertical.length == 4
      else
        vertical = []
      end
      # binding.pry
      # if @board.grid[@last_played_x]
      j += 1
    end
    # binding.pry
    return vertical if vertical == [char,char,char,char]
    nil
  end

  def diagonal1_pattern
    diagonal1_res=[]
    # check for the data in the diagonal /
    k = 0
    x_diag,y_diag = [],[]
    diagonal1.each{|arr| x_diag << arr[0]; y_diag << arr[1] }
    while k < x_diag.length do
      # binding.pry
      if @board.grid[x_diag[k]][y_diag[k]] != nil && @board.grid[x_diag[k]][y_diag[k]] == char
        diagonal1_res << @board.grid[x_diag[k]][y_diag[k]]
        break if diagonal1_res.length == 4
      else
        diagonal1_res = []
      end
      k += 1
    end
    # binding.pry
    return diagonal1_res if diagonal1_res == [char,char,char,char]
    nil
  end

  def diagonal2_pattern
    diagonal2_res=[]
    # check for the data in the diagonal \
    k = 0
    x_diag,y_diag = [],[]
    diagonal2.each{|arr| x_diag << arr[0]; y_diag << arr[1] }
    while k < x_diag.length do
      # binding.pry
      if @board.grid[x_diag[k]][y_diag[k]] != nil && @board.grid[x_diag[k]][y_diag[k]] == char
        diagonal2_res << @board.grid[x_diag[k]][y_diag[k]]
        break if diagonal2_res.length == 4
      else
        diagonal2_res = []
      end
      # binding.pry
      k += 1
    end
    # binding.pry
    return diagonal2_res if diagonal2_res == [char,char,char,char]
    nil
  end
end
