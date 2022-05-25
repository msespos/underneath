require 'rails_helper'

RSpec.describe Game, type: :model do
  subject(:game) { Game.new(id: 1) }
  #subject(:human) { Human.new(x_position: 0, y_position: 0, game_id: 1) }
  #subject(:card1) { described_class.new(x_position: 0, y_position: 0) }
  #subject(:card2) { described_class.new(x_position: 1, y_position: 1) }
  describe '#set_up' do
    context "when set_up is run three times" do
      it 'creates exactly four humans' do
        game.set_up
        game.set_up
        game.set_up
        number_of_humans = game.humans.count
        expect(number_of_humans).to eq(4)
      end
    end
    context "when set_up is run three times" do
      it 'creates exactly 45 cards' do
        game.set_up
        game.set_up
        game.set_up
        number_of_cards = game.cards.count
        expect(number_of_cards).to eq(45)
      end
    end
  end
end
