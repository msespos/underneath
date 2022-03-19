require 'rails_helper'

RSpec.describe Piece, type: :model do
  subject(:human) { Human.new(x_position: 0, y_position: 0) }
  describe '#start_and_finish_on_board?' do
    context "when the piece starts and finishes on the board" do
      it 'returns true' do
        start_and_finish = human.send(:start_and_finish_on_board?, [0, 2])
        expect(start_and_finish).to eq(true)
      end
      it 'returns true' do
        start_and_finish = human.send(:start_and_finish_on_board?, [1, 1])
        expect(start_and_finish).to eq(true)
      end
      it 'returns true' do
        start_and_finish = human.send(:start_and_finish_on_board?, [2, 2])
        expect(start_and_finish).to eq(true)
      end
      it 'returns true' do
        start_and_finish = human.send(:start_and_finish_on_board?, [1, 0])
        expect(start_and_finish).to eq(true)
      end
    end
    context "when the piece starts on the board and does not finish on the board" do
      it 'returns false' do
        start_and_finish = human.send(:start_and_finish_on_board?, [-1, 2])
        expect(start_and_finish).to eq(false)
      end
      it 'returns false' do
        start_and_finish = human.send(:start_and_finish_on_board?, [1, -1])
        expect(start_and_finish).to eq(false)
      end
      it 'returns false' do
        start_and_finish = human.send(:start_and_finish_on_board?, [-1, -1])
        expect(start_and_finish).to eq(false)
      end
      it 'returns false' do
        start_and_finish = human.send(:start_and_finish_on_board?, [-2, -2])
        expect(start_and_finish).to eq(false)
      end
    end
  end
  describe '#on_board?' do
    context "when the square is on the board" do
      it 'returns true' do
        on_board_or_not = human.send(:on_board?, [0, 2])
        expect(on_board_or_not).to eq(true)
      end
      it 'returns true' do
        on_board_or_not = human.send(:on_board?, [4, 4])
        expect(on_board_or_not).to eq(true)
      end
    end
    context "when the square is not on the board" do
      it 'returns false' do
        on_board_or_not = human.send(:on_board?, [-1, -1])
        expect(on_board_or_not).to eq(false)
      end
      it 'returns false' do
        on_board_or_not = human.send(:on_board?, [9, 10])
        expect(on_board_or_not).to eq(false)
      end
    end
  end
  describe '#number_of_squares_away' do
    context "when it is one square away" do
      it 'returns 1' do
        number_of_squares = human.send(:number_of_squares_away, [0, 1])
        expect(number_of_squares).to eq(1)
      end
      it 'returns 1' do
        number_of_squares = human.send(:number_of_squares_away, [1, 1])
        expect(number_of_squares).to eq(1)
      end
      it 'returns 1' do
        number_of_squares = human.send(:number_of_squares_away, [-1, 1])
        expect(number_of_squares).to eq(1)
      end
      it 'returns 1' do
        number_of_squares = human.send(:number_of_squares_away, [-1, 0])
        expect(number_of_squares).to eq(1)
      end
    end
    context "when it is two squares away" do
      it 'returns 2' do
        number_of_squares = human.send(:number_of_squares_away, [2, 0])
        expect(number_of_squares).to eq(2)
      end
      it 'returns 2' do
        number_of_squares = human.send(:number_of_squares_away, [-2, 2])
        expect(number_of_squares).to eq(2)
      end
      it 'returns 2' do
        number_of_squares = human.send(:number_of_squares_away, [2, 2])
        expect(number_of_squares).to eq(2)
      end
      it 'returns 2' do
        number_of_squares = human.send(:number_of_squares_away, [-2, 0])
        expect(number_of_squares).to eq(2)
      end
    end
  end
end