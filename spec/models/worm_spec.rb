require 'rails_helper'

RSpec.describe Worm, type: :model do
  subject(:worm) { described_class.new }
  describe '#queens_move?' do
    context "when the vector is a queen's move" do
      it 'returns true' do
        queens_move_or_not = worm.send(:queens_move?, [0, 2])
        expect(queens_move_or_not).to eq(true)
      end
      it 'returns true' do
        queens_move_or_not = worm.send(:queens_move?, [-1, 0])
        expect(queens_move_or_not).to eq(true)
      end
      it 'returns true' do
        queens_move_or_not = worm.send(:queens_move?, [-1, -1])
        expect(queens_move_or_not).to eq(true)
      end
      it 'returns true' do
        queens_move_or_not = worm.send(:queens_move?, [1, -1])
        expect(queens_move_or_not).to eq(true)
      end
      it 'returns true' do
        queens_move_or_not = worm.send(:queens_move?, [2, 2])
        expect(queens_move_or_not).to eq(true)
      end
      it 'returns true' do
        queens_move_or_not = worm.send(:queens_move?, [-2, 2])
        expect(queens_move_or_not).to eq(true)
      end
    end
    context "when the vector is not a queen's move" do
      it 'returns false' do
        queens_move_or_not = worm.send(:queens_move?, [0, 0])
        expect(queens_move_or_not).to eq(false)
      end
      it 'returns false' do
        queens_move_or_not = worm.send(:queens_move?, [-1, -2])
        expect(queens_move_or_not).to eq(false)
      end
      it 'returns false' do
        queens_move_or_not = worm.send(:queens_move?, [2, 1])
        expect(queens_move_or_not).to eq(false)
      end
      it 'returns false' do
        queens_move_or_not = worm.send(:queens_move?, [2, -1])
        expect(queens_move_or_not).to eq(false)
      end
      it 'returns false' do
        queens_move_or_not = worm.send(:queens_move?, [3, 0])
        expect(queens_move_or_not).to eq(false)
      end
      it 'returns false' do
        queens_move_or_not = worm.send(:queens_move?, [-4, -4])
        expect(queens_move_or_not).to eq(false)
      end
    end
  end
end
