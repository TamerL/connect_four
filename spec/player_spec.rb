# frozen_string_literal: true

require 'rspec/autorun'
require './src/player'

describe '.initialize' do
  it 'has a name' do
    player1 = Player.new('Tamer')
    expect(player1.name).to eq('Tamer')
  end
end
