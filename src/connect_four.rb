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
  pos = 0
  while @game.get_winner(pos).nil? && @game.board.is_full? == false
    @board.print_board
    # binding.pry
    puts "#{@game.player_turn.name} it's your turn! please select a position from 0 to #{Board::SIZE - 1}"
    begin
      input = gets.chomp
      @game.write_onboard(@game.player_turn, input)
      pos = input.to_i
    rescue StandardError => e
      puts e.message
    end
  end
  puts (@game.get_winner(pos).nil? ? 'The game is draw, no one wins!' : "#{@game.get_winner(pos).name} wins!").to_s
  @board.print_board
end

prepare_game
run_game
