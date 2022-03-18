require 'rails_helper'

RSpec.describe Human, type: :model do
  subject(:human) { described_class.new }
  describe '#kings_move?' do
    context "when the vector is a king's move" do
      it 'returns true' do
        kings_move_or_not = human.send(:kings_move?, [0, 1])
        expect(kings_move_or_not).to eq(true)
      end
      it 'returns true' do
        kings_move_or_not = human.send(:kings_move?, [-1, -1])
        expect(kings_move_or_not).to eq(true)
      end
      it 'returns true' do
        kings_move_or_not = human.send(:kings_move?, [-1, 0])
        expect(kings_move_or_not).to eq(true)
      end
      it 'returns true' do
        kings_move_or_not = human.send(:kings_move?, [1, -1])
        expect(kings_move_or_not).to eq(true)
      end
    end
    context "when the vector is not a king's move" do
      it 'returns false' do
        kings_move_or_not = human.send(:kings_move?, [0, 2])
        expect(kings_move_or_not).to eq(false)
      end
      it 'returns false' do
        kings_move_or_not = human.send(:kings_move?, [-1, -2])
        expect(kings_move_or_not).to eq(false)
      end
      it 'returns false' do
        kings_move_or_not = human.send(:kings_move?, [0, 0])
        expect(kings_move_or_not).to eq(false)
      end
      it 'returns false' do
        kings_move_or_not = human.send(:kings_move?, [3, 3])
        expect(kings_move_or_not).to eq(false)
      end
    end
  end
end
