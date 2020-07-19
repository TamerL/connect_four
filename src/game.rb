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
    # now will get the last played position on the grid in last_played_pos[x,y]
    @player_turn = @player_marker.reject { |k, v| v == player }.values.first
    # to toggle between players when the game is running
    build_winning_ranges
  end

  def build_winning_ranges
    @last_played_pos[1] = @board.grid[@last_played_pos[0]].length - 1
    @winning_ranges= []
    last_played_pos[0] > 3 ? x_range = Array(last_played_pos[0] - 3..6) : x_range = Array(0 ..last_played_pos[0] + 3)
    # for the horizontal winning pattern, when the grid has [...['x'],['x'],['x'],['x']...]
    last_played_pos[1] > 3 ? y_range = Array(last_played_pos[1] - 3..6) : y_range = Array(0 ..last_played_pos[1] + 3)
    # for the vertical winning pattern, when the grid has [...['x','x','x','x']...]
    to_be_combined_with_x_range = Array.new(x_range.length,last_played_pos[1])
    to_be_combined_with_y_range = Array.new(y_range.length,last_played_pos[0])
    winning_ranges << x_range.zip(to_be_combined_with_x_range)
    # i.e. for a line = 2 , winning_ranges[0] will equal to something line [[x_range[0],2],[x_range[1],2]...]
    winning_ranges << to_be_combined_with_y_range.zip(y_range)
    # i.e. for a col = 2 , winning_ranges[1] will equal to something line [[2,y_range[0]],[2,,y_range[1]]...]
    winning_ranges << x_range.product(y_range).select {|arr| arr[0]-arr[1] == last_played_pos[0] - last_played_pos[1]}
    # winning_ranges[2] is used to check the diagonal direction / it will combine the x_range with the y_range to match that pattern
    winning_ranges << x_range.product(y_range).select {|arr| arr[0]+arr[1] == last_played_pos[0] + last_played_pos[1]}
    # winning_ranges[3] is used to check the diagonal direction \ it will combine the x_range with the y_range in a different way to match that pattern
  end

  def get_winner
    return nil if last_played_pos[0] == nil
    result = []
    # will iterate in the winning patterns to find if 4 same characters exist in sequece
    winning_ranges.each { |array|
    result << collect_four(array)
    }
    # will decide the winner by checking the returned array of 4 identical characters
    array = result.find { |arr| arr == ['x']*4 || arr == ['o']*4}
    return @player_marker[array.uniq.first] if array
    nil
  end

  def collect_four(array)
    sequence_check=[]
    # will iterate in the passed array to find if 4 same characters exist in sequence
    array.each { |array|
      if @board.grid[array[0]][array[1]] != nil && @board.grid[array[0]][array[1]] == last_played_char
        sequence_check << @board.grid[array[0]][array[1]]
        break if sequence_check.length == 4
      else
        sequence_check = []
      end
    }
    sequence_check
  end
end
