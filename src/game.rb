# frozen_string_literal: true
# require './board'

class Game
  attr_accessor :board
  attr_reader :player1
  attr_reader :player2
  attr_reader :player_marker
  attr_accessor :player_turn

  def initialize(board:, player1:, player2:)
    @player1 = player1
    @player2 = player2
    @board = board
    @player_marker = { 'x' => player1, 'o' => player2 }
  end

  def write_onboard(player, pos)
    raise 'Only numbers in the mentioned range are allowed' if (pos.is_a? String) && (!pos.scan(/\D/).empty?)
    pos = pos.to_i
    last_played_char = @player_marker.invert[player]
    board.write_onboard(last_played_char, pos)
    @player_turn = @player_marker.reject { |k, v| v == player }.values.first
    # to switch between players when the game is running
  end

  def get_winner(pos)
    last_played_char = @board.grid[pos].last
    last_played_pos = [pos,@board.grid[pos].length - 1]
    return nil if last_played_pos[0] == nil
    winning_ranges = build_winning_ranges(last_played_char,last_played_pos)
    result = []
    winning_ranges.each { |array|
    result << collect_four(array,last_played_char)
    }
    # will decide the winner by checking the returned array of 4 identical characters
    array = result.find { |arr| arr == ['x']*4 || arr == ['o']*4}
    return @player_marker[array.uniq.first] if array
    nil
  end

  private

  def build_winning_ranges(last_played_char,last_played_pos)
    return [] if last_played_char.nil?
    winning_ranges= []
    last_played_pos[1] = @board.grid[last_played_pos[0]].length - 1
    horizontal = horizontal_range(last_played_pos)
    # To be used to check the horizontal winning pattern range, when the grid has [...['x'],['x'],['x'],['x']...]
    vertical = vertical_range(last_played_pos)
    # To be used to check the vertical winning pattern, when the grid has [...['x','x','x','x']...]
    winning_ranges << horizontal
    winning_ranges << vertical
    winning_ranges << diagonal1_range(last_played_pos,horizontal,vertical)
    # winning_ranges[3] is used to check the diagonal direction \
    winning_ranges << diagonal2_range(last_played_pos,horizontal,vertical)
    # winning_ranges[3] is used to check the diagonal direction \
  end

  def horizontal_range(last_played_pos)
    # This is the two dimentional array of points on the grid which checks the
    # horizontal winning patter
    # i.e. for a line = 2
    # winning_ranges[0] will equal to something line [[x_range[0],2],[x_range[1],2]...]
    array = (0..6).to_a.collect{|a| [a,last_played_pos[1]]}
    array = array.select{|a| a[0] > last_played_pos[0] - 4 && a[0] < last_played_pos[0] + 4}
    array
  end

  def vertical_range(last_played_pos)
    # This is the two dimentional array of points on the grid which checks the
    # vertical winning patter
    # i.e. for a col = 2
    # winning_ranges[1] will equal to something line [[2,y_range[0]],[2,,y_range[1]]...]
    array = (0..6).to_a.collect{|a| [last_played_pos[0],a]}
    array = array.select{|a| a[1] > last_played_pos[1] - 4 && a[1] < last_played_pos[1] + 4}
    last_played_pos[1] > 3 ? y_range = Array(last_played_pos[1] - 3..6) : y_range = Array(0 ..last_played_pos[1] + 3)
    array
  end

  def diagonal1_range(last_played_pos,horizontal,vertical)
    #is used to check the diagonal direction /
    array = horizontal.map(&:first).product(vertical.map(&:last)).select {|arr|
      arr[0] - arr[1] == last_played_pos[0] - last_played_pos[1]
    }
    array
  end

  def diagonal2_range(last_played_pos,horizontal,vertical)
    #is used to check the diagonal direction \
    array = horizontal.map(&:first).product(vertical.map(&:last)).select {|arr|
      arr[0] + arr[1] == last_played_pos[0] + last_played_pos[1]
    }
    array
  end

  def collect_four(array,last_played_char)
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
