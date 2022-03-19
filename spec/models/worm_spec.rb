require 'rails_helper'

RSpec.describe Worm, type: :model do
  subject(:worm1) { described_class.new(last_move_x_direction: 2, last_move_y_direction: 2) }
  subject(:worm2) { described_class.new(last_move_x_direction: 0, last_move_y_direction: 1) }
  describe '#queens_move?' do
    context "when the vector is a queen's move" do
      it 'returns true' do
        queens_move_or_not = worm1.send(:queens_move?, [0, 2])
        expect(queens_move_or_not).to eq(true)
      end
      it 'returns true' do
        queens_move_or_not = worm1.send(:queens_move?, [-1, 0])
        expect(queens_move_or_not).to eq(true)
      end
      it 'returns true' do
        queens_move_or_not = worm1.send(:queens_move?, [-1, -1])
        expect(queens_move_or_not).to eq(true)
      end
      it 'returns true' do
        queens_move_or_not = worm1.send(:queens_move?, [1, -1])
        expect(queens_move_or_not).to eq(true)
      end
      it 'returns true' do
        queens_move_or_not = worm1.send(:queens_move?, [2, 2])
        expect(queens_move_or_not).to eq(true)
      end
      it 'returns true' do
        queens_move_or_not = worm1.send(:queens_move?, [-2, 2])
        expect(queens_move_or_not).to eq(true)
      end
    end
    context "when the vector is not a queen's move" do
      it 'returns false' do
        queens_move_or_not = worm1.send(:queens_move?, [0, 0])
        expect(queens_move_or_not).to eq(false)
      end
      it 'returns false' do
        queens_move_or_not = worm1.send(:queens_move?, [-1, -2])
        expect(queens_move_or_not).to eq(false)
      end
      it 'returns false' do
        queens_move_or_not = worm1.send(:queens_move?, [2, 1])
        expect(queens_move_or_not).to eq(false)
      end
      it 'returns false' do
        queens_move_or_not = worm1.send(:queens_move?, [2, -1])
        expect(queens_move_or_not).to eq(false)
      end
      it 'returns false' do
        queens_move_or_not = worm1.send(:queens_move?, [3, 0])
        expect(queens_move_or_not).to eq(false)
      end
      it 'returns false' do
        queens_move_or_not = worm1.send(:queens_move?, [-4, -4])
        expect(queens_move_or_not).to eq(false)
      end
    end
  end
  describe '#same_direction_as_last_move?' do
    context "when the vector is the same direction as the last move" do
      it 'returns true' do
        same_direction_or_not = worm1.send(:same_direction_as_last_move?, [2, 2])
        expect(same_direction_or_not).to eq(true)
      end
      it 'returns true' do
        same_direction_or_not = worm1.send(:same_direction_as_last_move?, [1, 1])
        expect(same_direction_or_not).to eq(true)
      end
      it 'returns true' do
        same_direction_or_not = worm2.send(:same_direction_as_last_move?, [0, 1])
        expect(same_direction_or_not).to eq(true)
      end
      it 'returns true' do
        same_direction_or_not = worm2.send(:same_direction_as_last_move?, [0, 2])
        expect(same_direction_or_not).to eq(true)
      end
    end
    context "when the vector is not the same direction as the last move" do
      it 'returns false' do
        same_direction_or_not = worm1.send(:same_direction_as_last_move?, [2, 0])
        expect(same_direction_or_not).to eq(false)
      end
      it 'returns false' do
        same_direction_or_not = worm1.send(:same_direction_as_last_move?, [0, 1])
        expect(same_direction_or_not).to eq(false)
      end
      it 'returns false' do
        same_direction_or_not = worm2.send(:same_direction_as_last_move?, [1, 1])
        expect(same_direction_or_not).to eq(false)
      end
      it 'returns false' do
        same_direction_or_not = worm2.send(:same_direction_as_last_move?, [-1, 2])
        expect(same_direction_or_not).to eq(false)
      end
    end
  end
  describe '#opposite_direction_as_last_move?' do
    context "when the vector is the opposite direction as the last move" do
      it 'returns true' do
        opposite_direction_or_not = worm1.send(:opposite_direction_as_last_move?, [-1, -1])
        expect(opposite_direction_or_not).to eq(true)
      end
      it 'returns true' do
        opposite_direction_or_not = worm1.send(:opposite_direction_as_last_move?, [-2, -2])
        expect(opposite_direction_or_not).to eq(true)
      end
      it 'returns true' do
        opposite_direction_or_not = worm2.send(:opposite_direction_as_last_move?, [0, -1])
        expect(opposite_direction_or_not).to eq(true)
      end
      it 'returns true' do
        opposite_direction_or_not = worm2.send(:opposite_direction_as_last_move?, [0, -2])
        expect(opposite_direction_or_not).to eq(true)
      end
    end
    context "when the vector is not the opposite direction as the last move" do
      it 'returns false' do
        opposite_direction_or_not = worm1.send(:opposite_direction_as_last_move?, [2, 2])
        expect(opposite_direction_or_not).to eq(false)
      end
      it 'returns false' do
        opposite_direction_or_not = worm1.send(:opposite_direction_as_last_move?, [1, 0])
        expect(opposite_direction_or_not).to eq(false)
      end
      it 'returns false' do
        opposite_direction_or_not = worm2.send(:opposite_direction_as_last_move?, [0, 1])
        expect(opposite_direction_or_not).to eq(false)
      end
      it 'returns false' do
        opposite_direction_or_not = worm2.send(:opposite_direction_as_last_move?, [-1, -2])
        expect(opposite_direction_or_not).to eq(false)
      end
    end
  end
  describe '#queens_move?' do
    context "when the vector is at 45 degrees" do
      it 'returns 45' do
        angle_measure = worm1.send(:angle, [2, 2])
        expect(angle_measure).to eq(45)
      end
    end
    context "when the vector is at 135 degrees" do
      it 'returns 135' do
        angle_measure = worm1.send(:angle, [-1, 1])
        expect(angle_measure).to eq(135)
      end
    end
    context "when the vector is at 180 degrees" do
      it 'returns 180' do
        angle_measure = worm1.send(:angle, [-1, 0])
        expect(angle_measure).to eq(180)
      end
    end
    context "when the vector is at 315 degrees" do
      it 'returns 315' do
        angle_measure = worm1.send(:angle, [2, -2])
        expect(angle_measure).to eq(315)
      end
    end
  end
end
