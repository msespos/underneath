require 'rails_helper'

RSpec.describe Worm, type: :model do
  subject(:game1) { Game.new(id: 1) }
  subject(:worm1) { described_class.new(x_position: 7, y_position: 7,
                                        last_move_x_direction: nil,
                                        last_move_y_direction: nil) }
  subject(:worm2) { described_class.new(last_move_x_direction: 2,
                                        last_move_y_direction: 2) }
  subject(:card1) { Card.new(x_position: 5, y_position: 5, type: 'Rock') }
  subject(:card2) { Card.new(x_position: 7, y_position: 5, type: 'Blank') }

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
        queens_move_or_not = worm1.send(:queens_move?, [-2, 2])
        expect(queens_move_or_not).to eq(true)
      end
      it 'returns true' do
        queens_move_or_not = worm1.send(:queens_move?, [3, 0])
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
    end
  end
  describe '#last_move' do
    context 'when the last move is nil' do
      it 'returns nil' do
        worms_last_move = worm1.send(:last_move)
        expect(worms_last_move).to eq(nil)
      end
    end
    context 'when the last move is (2, 2)' do
      it 'returns [2, 2]' do
        worms_last_move = worm2.send(:last_move)
        expect(worms_last_move).to eq([2, 2])
      end
    end
  end
  describe '#same_direction?' do
    context 'when the vector is the same direction as the last move' do
      it 'returns true' do
        same_direction_or_not = worm1.send(:same_direction?, [2, 2], [2, 2])
        expect(same_direction_or_not).to eq(true)
      end
      it 'returns true' do
        same_direction_or_not = worm2.send(:same_direction?, [0, 1], [0, 2])
        expect(same_direction_or_not).to eq(true)
      end
    end
    context 'when the vector is not the same direction as the last move' do
      it 'returns false' do
        same_direction_or_not = worm1.send(:same_direction?, [2, 0], [2, 2])
        expect(same_direction_or_not).to eq(false)
      end
      it 'returns false' do
        same_direction_or_not = worm2.send(:same_direction?, [1, 1], [0, 1])
        expect(same_direction_or_not).to eq(false)
      end
    end
  end
  describe '#opposite_direction?' do
    context 'when the vector is the opposite direction as the last move' do
      it 'returns true' do
        opposite_direction_or_not = worm1.send(:opposite_direction?, [-1, -1], [2, 2])
        expect(opposite_direction_or_not).to eq(true)
      end
      it 'returns true' do
        opposite_direction_or_not = worm2.send(:opposite_direction?, [0, -2], [0, 1])
        expect(opposite_direction_or_not).to eq(true)
      end
    end
    context 'when the vector is not the opposite direction as the last move' do
      it 'returns false' do
        opposite_direction_or_not = worm1.send(:opposite_direction?, [2, 2], [1, 1])
        expect(opposite_direction_or_not).to eq(false)
      end
      it 'returns false' do
        opposite_direction_or_not = worm2.send(:opposite_direction?, [-1, -2], [0, 2])
        expect(opposite_direction_or_not).to eq(false)
      end
    end
  end
  describe '#angle' do
    context 'when the vector is at 45 degrees' do
      it 'returns 45' do
        angle_measure = worm1.send(:angle, [2, 2])
        expect(angle_measure).to eq(45)
      end
    end
    context 'when the vector is at 135 degrees' do
      it 'returns 135' do
        angle_measure = worm1.send(:angle, [-1, 1])
        expect(angle_measure).to eq(135)
      end
    end
    context 'when the vector is at 180 degrees' do
      it 'returns 180' do
        angle_measure = worm1.send(:angle, [-1, 0])
        expect(angle_measure).to eq(180)
      end
    end
    context 'when the vector is at 315 degrees' do
      it 'returns 315' do
        angle_measure = worm1.send(:angle, [2, -2])
        expect(angle_measure).to eq(315)
      end
    end
  end
  describe '#rock?' do
    before do
      game1.cards << [card1, card2]
    end

    context 'when the target square is a rock' do
      it 'returns true' do
        allow(worm1).to receive(:game).and_return(game1)
        a_rock = worm1.send(:rock?, [-2, -2])
        expect(a_rock).to eq(true)
      end
    end
    context 'when the target square is not a rock' do
      it 'returns false' do
        allow(worm1).to receive(:game).and_return(game1)
        a_rock = worm1.send(:rock?, [0, -2])
        expect(a_rock).to eq(false)
      end
    end
  end
end
