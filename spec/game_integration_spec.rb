# frozen_string_literal: true

require 'rspec/autorun'
require './src/game'
require './src/player'
require './src/board'
require 'pry'

describe 'Running different game scenarios and checking the results' do
  before do
    @player1 = Player.new('x')
    @player2 = Player.new('o')
    @board = Board.new
    @game = Game.new(player1: @player1, player2: @player2, board: @board)
  end

  context '1) Winning scenario #1: Player1 wins:' do
    # pending
    it "returns array of 7 empty arrays when the game start" do
      expect(@game.board.grid).to eq([[],[],[],[],[],[],[]])
    end
    # pending
    it "allow players to write to the grid, then returns player1 object" do
      expect(@game.board.grid).to eq([[],[],[],[],[],[],[]])
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 3)
      expect(@game.board.grid).to eq([[],[],[],['x'],[],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 0)
      expect(@game.board.grid).to eq([['o'],[],[],['x'],[],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 2)
      expect(@game.board.grid).to eq([['o'],[],['x'],['x'],[],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 6)
      expect(@game.board.grid).to eq([['o'],[],['x'],['x'],[],[],['o']])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 5)
      expect(@game.board.grid).to eq([['o'],[],['x'],['x'],[],['x'],['o']])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 1)
      expect(@game.board.grid).to eq([['o'],['o'],['x'],['x'],[],['x'],['o']])
      expect(@game.get_winner).to eq(nil)
      @game.write_onboard(@player1, 4)
      expect(@game.board.grid).to eq([['o'],['o'],['x'],['x'],['x'],['x'],['o']])
      expect(@game.get_winner).to eq(@player1)
    end
  end

  context '2) Winning scenario #2: Player1 wins' do
    # pending
    it "allow players to write to the grid, then returns player1 object" do
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 3)
      expect(@game.board.grid).to eq([[],[],[],['x'],[],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 1)
      expect(@game.board.grid).to eq([[],['o'],[],['x'],[],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 3)
      expect(@game.board.grid).to eq([[],['o'],[],['x','x'],[],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 6)
      expect(@game.board.grid).to eq([[],['o'],[],['x','x'],[],[],['o']])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 3)
      expect(@game.board.grid).to eq([[],['o'],[],['x','x','x'],[],[],['o']])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 0)
      expect(@game.board.grid).to eq([['o'],['o'],[],['x','x','x'],[],[],['o']])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 3)
      expect(@game.board.grid).to eq([['o'],['o'],[],['x','x','x','x'],[],[],['o']])
      expect(@game.get_winner).to eq(@player1)
    end
  end

  context '3) Winning scenario #3: Player2 wins' do
    # pending
    it "allow players to write to the grid, then returns player2 object" do
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 3)
      expect(@game.board.grid).to eq([[],[],[],['x'],[],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 1)
      expect(@game.board.grid).to eq([[],['o'],[],['x'],[],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 2)
      expect(@game.board.grid).to eq([[],['o'],['x'],['x'],[],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 2)
      expect(@game.board.grid).to eq([[],['o'],['x','o'],['x'],[],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 3)
      expect(@game.board.grid).to eq([[],['o'],['x','o'],['x','x'],[],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 3)
      expect(@game.board.grid).to eq([[],['o'],['x','o'],['x','x','o'],[],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 4)
      expect(@game.board.grid).to eq([[],['o'],['x','o'],['x','x','o'],['x'],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 4)
      expect(@game.board.grid).to eq([[],['o'],['x','o'],['x','x','o'],['x','o'],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 4)
      expect(@game.board.grid).to eq([[],['o'],['x','o'],['x','x','o'],['x','o','x'],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 4)
      expect(@game.board.grid).to eq([[],['o'],['x','o'],['x','x','o'],['x','o','x','o'],[],[]])
      expect(@game.get_winner).to eq(@player2)
      expect(@board.is_full?).to eq(false)
    end
  end

  context '4) Winning scenario #4: Player2 wins' do
    # pending
    it "allow players to write to the grid, then returns player2 object" do
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 3)
      expect(@game.board.grid).to eq([[],[],[],['x'],[],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 3)
      expect(@game.board.grid).to eq([[],[],[],['x','o'],[],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 3)
      expect(@game.board.grid).to eq([[],[],[],['x','o','x'],[],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 4)
      expect(@game.board.grid).to eq([[],[],[],['x','o','x'],['o'],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 4)
      expect(@game.board.grid).to eq([[],[],[],['x','o','x'],['o','x'],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 4)
      expect(@game.board.grid).to eq([[],[],[],['x','o','x'],['o','x','o'],[],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 5)
      expect(@game.board.grid).to eq([[],[],[],['x','o','x'],['o','x','o'],['x'],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 5)
      expect(@game.board.grid).to eq([[],[],[],['x','o','x'],['o','x','o'],['x','o'],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 2)
      expect(@game.board.grid).to eq([[],[],['x'],['x','o','x'],['o','x','o'],['x','o'],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 3)
      expect(@game.board.grid).to eq([[],[],['x'],['x','o','x','o'],['o','x','o'],['x','o'],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player1, 1)
      expect(@game.board.grid).to eq([[],['x'],['x'],['x','o','x','o'],['o','x','o'],['x','o'],[]])
      expect(@game.get_winner).to eq(nil)
      expect(@board.is_full?).to eq(false)
      @game.write_onboard(@player2, 6)
      binding.pry
      expect(@game.board.grid).to eq([[],['x'],['x'],['x','o','x','o'],['o','x','o'],['x','o'],['o']])
      expect(@game.get_winner).to eq(@player2)
      expect(@board.is_full?).to eq(false)
    end
  end

  context '5) Draw scenario: The game is draw' do
    # pending
    it "allow players to write to the grid, then returns 'The game is draw, no body wins!'" do
      row=0
      col=0
      while row < 7 do
        pattern = row/3
        while col < 7 do
          if pattern.even?
            if col.even?
              @game.write_onboard(@player1,col)
              expect(@game.get_winner).to eq(nil)
            else
              @game.write_onboard(@player2,col)
              expect(@game.get_winner).to eq(nil)
              expect(@board.is_full?).to eq(false)
            end
          else
            if col.even?
              @game.write_onboard(@player2,col)
              expect(@game.get_winner).to eq(nil)
              expect(@board.is_full?).to eq(false)
            else
              @game.write_onboard(@player1,col)
              expect(@game.get_winner).to eq(nil)
            end
          end
          col+=1
        end
        col=0
        row+=1
      end
      expect(@game.board.grid).to eq([["x", "x", "x", "o", "o", "o", "x"], ["o", "o", "o", "x", "x", "x", "o"], ["x", "x", "x", "o", "o", "o", "x"], ["o", "o", "o", "x", "x", "x", "o"], ["x", "x", "x", "o", "o", "o", "x"], ["o", "o", "o", "x", "x", "x", "o"], ["x", "x", "x", "o", "o", "o", "x"]])
      expect(@board.is_full?).to eq(true)
    end
  end

end

describe 'Some failure scenarios:' do
  context "when the board doesn't exist" do
    # pending
    it "raises an error 'missing keyword: board'" do
      x = Player.new('x')
      o = Player.new('o')
      expect do
        game = Game.new(player1: x, player2: o)
      end.to raise_error('missing keyword: board')
    end
  end

  context 'when the players do not exist' do
    # pending
    it "raises an error 'missing keywords: player1, player2'" do
      board = Board.new
      expect do
        game = Game.new(board: board)
      end.to raise_error('missing keywords: player1, player2')
    end
  end


end
