require 'rails_helper'

RSpec.describe Card, type: :model do
  subject(:game) { Game.new(id: 1) }
  subject(:human) { Human.new(x_position: 0, y_position: 0, game_id: 1) }
  subject(:card1) { described_class.new(x_position: 0, y_position: 0) }
  subject(:card2) { described_class.new(x_position: 1, y_position: 1) }
  describe '#human_on_card?' do
    before do
      game.humans << human
      game.cards << card1
      game.cards << card2      
    end
    context "when there is a human on the card" do
      it 'returns the human' do
        on_card = card1.send(:human_on_card?)
        expect(on_card).to eq(human)
      end
    end
    context "when there is not a human on the card" do
      it 'returns nil' do
        on_card = card2.send(:human_on_card?)
        expect(on_card).to eq(nil)
      end
    end
  end
end