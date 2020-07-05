# frozen_string_literal: true

require 'rspec/autorun'
require './src/board'
require 'pry'

describe 'Board' do
  before do
    @board = Board.new
  end

  describe '.initialize' do
    it 'returns an empty board' do
      expect(@board.grid).to eq([[],[],[],[],[],[],[]])
      # expect(@board).to receive(:grid).and_return([[0,0,0],[0,0,0],[0,0,0]])
    end
  end

  describe '#write_onboard' do
    it "will write 'mark' on the board grid" do
      @board.write_onboard('mark', 4)
      # 0   0  0
      # 0'mark'0
      # 0   0  0
      expect(@board.grid).to eq([[],[],[],[],['mark'],[],[]])
    end

    it 'raises an error if the column is full, having 7 elements already' do
      7.times { @board.write_onboard('mark',4)}
      # 0   0  0
      # 0'mark'0
      # 0   0  0
      # binding.pry
      expect do
        @board.write_onboard('mark', 4)
      end.to raise_error('Column 4 is full, please insert in other columns')
    end

    it 'raises an error if a player tries to write on an invalid place' do
      # 000
      # 000
      # 000
      expect do
        @board.write_onboard('mark', 9)
      end.to raise_error('Invalid position! please select from 0 to 6')
    end
  end

  describe '#is_full?' do
    it 'returns false if the board is not full' do
      expect(@board.is_full?).to eq(false)
    end

    it 'returns true if the board is full' do
      i = 0
      while i < 7 do
        7.times { @board.write_onboard('mark',i)}
        i += 1
      end
      expect(@board.is_full?).to eq(true)
    end
  end
end
