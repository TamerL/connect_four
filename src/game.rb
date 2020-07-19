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
    build_x_range = Array.new(x.length,last_played_pos[1])
    build_y_range = Array.new(y.length,last_played_pos[0])
    winning_ranges << x.zip(build_x_range)
    winning_ranges << build_y_range.zip(y)
    winning_ranges << x.product(y).select {|arr| arr[0]-arr[1] == last_played_pos[0] - last_played_pos[1]}
    winning_ranges << x.product(y).select {|arr| arr[0]+arr[1] == last_played_pos[0] + last_played_pos[1]}
    # binding.pry
  end

  def get_winner
    return nil if last_played_pos[0] == nil
    result = []
    # binding.pry
    winning_ranges.each { |arr|
    result << iterator_loop(arr)
    }
    # result << vertical_pattern
    #
    # # binding.pry
    # result << diagonal1_pattern
    # result << diagonal2_pattern
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

  def iterator_loop(arr)
    sequence_check=[]
    # check for the data in the diagonal \
    k = 0
    x_range,y_range = [],[]


    arr.each{|arr| x_range << arr[0]; y_range << arr[1] }
    while k < x_range.length do
      # binding.pry
      if @board.grid[x_range[k]][y_range[k]] != nil && @board.grid[x_range[k]][y_range[k]] == last_played_char
        sequence_check << @board.grid[x_range[k]][y_range[k]]
        break if sequence_check.length == 4
      else
        sequence_check = []
      end
      # binding.pry
      k += 1
    end
    # binding.pry


      # binding.pry


    return sequence_check if sequence_check == [last_played_char,last_played_char,last_played_char,last_played_char]
    nil
  end
end
