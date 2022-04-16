require 'rails_helper'

RSpec.describe Human, type: :model do
  subject(:game1) { Game.new(id: 1) }
  subject(:human1) { described_class.new(x_position: 0, y_position: 0, game_id: 1) }
  subject(:human2) { described_class.new(x_position: 0, y_position: 1, game_id: 1) }
  subject(:human3) { described_class.new(x_position: 1, y_position: 0, game_id: 1) }

  describe '#kings_move?' do
    context "when the vector is a king's move" do
      it 'returns true' do
        kings_move_or_not = human1.send(:kings_move?, [0, 1])
        expect(kings_move_or_not).to eq(true)
      end
      it 'returns true' do
        kings_move_or_not = human1.send(:kings_move?, [-1, -1])
        expect(kings_move_or_not).to eq(true)
      end
      it 'returns true' do
        kings_move_or_not = human1.send(:kings_move?, [-1, 0])
        expect(kings_move_or_not).to eq(true)
      end
      it 'returns true' do
        kings_move_or_not = human1.send(:kings_move?, [1, -1])
        expect(kings_move_or_not).to eq(true)
      end
    end
    context "when the vector is not a king's move" do
      it 'returns false' do
        kings_move_or_not = human1.send(:kings_move?, [0, 2])
        expect(kings_move_or_not).to eq(false)
      end
      it 'returns false' do
        kings_move_or_not = human1.send(:kings_move?, [-1, -2])
        expect(kings_move_or_not).to eq(false)
      end
      it 'returns false' do
        kings_move_or_not = human1.send(:kings_move?, [0, 0])
        expect(kings_move_or_not).to eq(false)
      end
      it 'returns false' do
        kings_move_or_not = human1.send(:kings_move?, [3, 3])
        expect(kings_move_or_not).to eq(false)
      end
    end
  end
  describe '#human?' do
    before do
      game1.humans << human1
      game1.humans << human2
      game1.humans << human3
    end

    context 'when the target square is a human' do
      it 'returns true' do
        allow(human1).to receive(:game).and_return(game1)
        a_human = human1.send(:human?, [0, 1])
        expect(a_human).to eq(true)
      end
    end
    context 'when the target square is not a human' do
      it 'returns false' do
        allow(human1).to receive(:game).and_return(game1)
        a_human = human1.send(:human?, [1, 1])
        expect(a_human).to eq(false)
      end
    end
  end
end
