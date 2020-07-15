# frozen_string_literal: true

require 'rspec/autorun'
require './src/game'
require './src/board'
require 'pry'

describe 'Game' do
  before do
    @player1 = double('Player', name: 'Player1')
    @player2 = double('Player', name: 'Player2')
    @board = double('Board', grid: [[],[],[],[],[],[],[]])
    @game = Game.new(board: @board, player1: @player1, player2: @player2)
  end

  describe '.initialize' do
    it 'returns the instance variables when calling them through @game.variable' do
      expect(@game.player1).to eq(@player1)
      expect(@game.player2).to eq(@player2)
      expect(@game.board).to eq(@board)
      expect(@game.player_marker).to eq({ 'x' => @player1, 'o' => @player2 })
    end
  end

  describe '#write_onboard' do
    context 'when player1 plays' do
      it 'triggers write_onboard of the board' do
        expect(@board).to receive(:write_onboard).with('x', 4)
        @game.write_onboard(@player1, 4)
      end
    end
    context 'when player2 plays' do
      it 'triggers write_onboard of the board' do
        expect(@board).to receive(:write_onboard).with('o', 4)
        @game.write_onboard(@player2, 4)
      end
    end
    context "when a player's input is not an Integer" do
      it "raises an error 'Only numbers in the mentioned range are allowed'" do
        expect do
          @game.write_onboard(@player2, 'wrong_input')
        end.to raise_error('Only numbers in the mentioned ranges are allowed')
      end
    end
  end

  describe '#get_winner' do
    context 'check for a winner in the row' do
      it "returns @player1 when the board has 4 consecutive 'x' in a row" do
        expect(@board).to receive(:write_onboard).with('x', 1)
        @game.write_onboard(@player1,1)
        allow(@board).to receive(:grid).and_return([[],['x'],['x'],['x'],['x'],[],[]])
        expect(@game.get_winner).to eq(@player1)
      end
    end

    context 'check for a winner in the column' do
      it "returns @player2 when the board has 4 consecutive 'o' in a column" do
        expect(@board).to receive(:write_onboard).with('o', 3)
        @game.write_onboard(@player2,3)
        allow(@board).to receive(:grid).and_return([[],[],[],['o','o','o','o'],[],[],[]])
        expect(@game.get_winner).to eq(@player2)
      end
    end

    context 'check for the winner in the digonals patterns' do
      it "returns @player1 when the \ diagonal is full of x" do
        expect(@board).to receive(:write_onboard).with('o', 3)
        @game.write_onboard(@player2,3)
        allow(@board).to receive(:grid).and_return([[],['x'],['x'],['x','o','x','o'],['o','x','o'],['x','o'],['o']])
        expect(@game.get_winner).to eq(@player2)
      end

      it 'returns @player2 when the / diagonal is full of o' do
        expect(@board).to receive(:write_onboard).with('o', 3)
        @game.write_onboard(@player2,3)
        allow(@board).to receive(:grid).and_return([[],['o'],['x','o'],['x','x','o'],['x','o','x','o'],[],[]])
        expect(@game.get_winner).to eq(@player2)
      end
    end

    context 'when the grid is not full and there is no winner' do
      it 'returns nil' do
        expect(@board).to receive(:write_onboard).with('o', 3)
        @game.write_onboard(@player2,3)
        allow(@board).to receive(:grid).and_return([[],['x'],['x'],['x','o','x','o'],['o','x','o'],['x','o'],[]])
        expect(@game.get_winner).to eq(nil)
      end
    end

    context 'when the grid is full and there is no winner' do
      it 'returns nil' do
        expect(@board).to receive(:write_onboard).with('x', 3)
        @game.write_onboard(@player1,3)
        allow(@board).to receive(:grid).and_return([["x", "x", "x", "o", "o", "o", "x"], ["o", "o", "o", "x", "x", "x", "o"], ["x", "x", "x", "o", "o", "o", "x"], ["o", "o", "o", "x", "x", "x", "o"], ["x", "x", "x", "o", "o", "o", "x"], ["o", "o", "o", "x", "x", "x", "o"], ["x", "x", "x", "o", "o", "o", "x"]])
        expect(@game.get_winner).to eq(nil)
      end
    end

    context 'when the grid is full and there is a winner, if it is player2' do
      it 'returns @player2' do
        expect(@board).to receive(:write_onboard).with('o', 6)
        @game.write_onboard(@player2,6)
        allow(@board).to receive(:grid).and_return([["x", "x", "x", "o", "o", "o", "x"], ["o", "o", "o", "x", "x", "x", "o"], ["x", "x", "x", "o", "o", "o", "x"], ["o", "o", "o", "x", "x", "x", "o"], ["x", "x", "x", "o", "o", "o", "x"], ["o", "o", "o", "x", "x", "x", "o"], ["x", "x", "x", "o", "o", "o", "o"]])
        expect(@game.get_winner).to eq(@player2)
      end
    end
  end
end
