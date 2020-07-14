# frozen_string_literal: true

require './player'
require './board'
require './game'
require 'pry'

# running the Game:
def prepare_game
  puts "Welcome to Connect Four :) \n\nPlayer1, please enter your name:"
  # asking for players names and creating players instances
  player1 = Player.new(gets.chomp)
  puts "Hi #{player1.name}\n\nPlayer2, please enter your name:"
  player2 = Player.new(gets.chomp)
  puts "Hi #{player2.name}\n\nStarting the game now, get ready!\n"
  @board = Board.new
  @game = Game.new(board: @board, player1: player1, player2: player2)
  # binding.pry
  @game.player_turn = player1
end

def run_game
  while @game.get_winner.nil? && @game.board.is_full? == false
    print_game
    # binding.pry
    puts "#{@game.player_turn.name} it's your turn! please select a position from 0 to #{Board::SIZE - 1}"
    begin
      @game.write_onboard(@game.player_turn, gets.chomp.to_i)
    rescue StandardError => e
      puts e.message
    end
  end
  puts (@game.get_winner.nil? ? 'The game is draw, no one wins!' : "#{@game.get_winner.name} wins!").to_s
  print_game
end

def print_game
  col = 0
  index = Board::SIZE - 1
  while index >= 0 do
    print "\n|"
    while col < Board::SIZE do
      # binding.pry
      @board.grid[col][index].nil? ? (print "  #{col}  |") : (print "  #{@board.grid[col][index]}  |")
      col += 1
    end
    puts "\n" + "------" *  Board::SIZE + "\n"
    col = 0
    index -= 1
    # binding.pry
  end
end

prepare_game
run_game
