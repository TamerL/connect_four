# frozen_string_literal: true

class Board
  attr_reader :grid

  SIZE = 7

  # def grid=(grid)
  #   @grid = grid
  # end
  #
  # def grid
  #   @grid
  # end

  def initialize
    # @grid = Array.new(SIZE){Array.new(SIZE).map{|e|e=0}}
    @grid = []
    7.times {@grid << []}
    # binding.pry
  end

  def write_onboard(str, pos)
    # binding.pry
    raise "Invalid position! please select from 0 to #{SIZE - 1}" if pos >= SIZE
    #  only accept positions from 0 to 6

    raise "The board is full, Game over!" if self.is_full?

    raise "Column #{pos} is full, please insert in other columns" unless @grid[pos].length < SIZE
    # Check the pos has something else than 0 or nil then it's already been written before

    @grid[pos] << str
    # Write on pos
  end

  def is_full?
    return false if @grid.find { |arr| arr.length < SIZE }

    # elsif the board still have a zero means still have empty place
    true
  end
end
