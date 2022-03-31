require 'rails_helper'

RSpec.describe Piece, type: :model do
  subject(:human_00) { Human.new(x_position: 0, y_position: 0) }
  subject(:human_12) { Human.new(x_position: 1, y_position: 2) }
  subject(:human_75) { Human.new(x_position: 7, y_position: 5) }
  subject(:human_77) { Human.new(x_position: 7, y_position: 7) }
  subject(:worm_00_n10) { Worm.new(x_position: 0, y_position: 0,
                                  last_move_x_direction: -1,
                                  last_move_y_direction: 0) }
  subject(:worm_12_n1n1) { Worm.new(x_position: 1, y_position: 2,
                                    last_move_x_direction: -1,
                                    last_move_y_direction: -1) }
  subject(:worm_44_n22) { Worm.new(x_position: 4, y_position: 4,
                                    last_move_x_direction: -2,
                                    last_move_y_direction: 2) }
  subject(:worm_75_10) { Worm.new(x_position: 7, y_position: 5,
                                  last_move_x_direction: 1,
                                  last_move_y_direction: 0) }
  subject(:worm_77_n1n1) { Worm.new(x_position: 7, y_position: 7,
                                    last_move_x_direction: -1,
                                    last_move_y_direction: -1) }
  describe '#start_and_finish_on_board?' do
    context 'when the piece starts and finishes on the board' do
      it 'returns true' do
        start_and_finish = human_00.send(:start_and_finish_on_board?, [0, 2])
        expect(start_and_finish).to eq(true)
      end
      it 'returns true' do
        start_and_finish = human_00.send(:start_and_finish_on_board?, [1, 1])
        expect(start_and_finish).to eq(true)
      end
    end
    context 'when the piece starts on the board and does not finish on the board' do
      it 'returns false' do
        start_and_finish = human_00.send(:start_and_finish_on_board?, [-1, 2])
        expect(start_and_finish).to eq(false)
      end
      it 'returns false' do
        start_and_finish = human_00.send(:start_and_finish_on_board?, [1, -1])
        expect(start_and_finish).to eq(false)
      end
    end
  end
  describe '#on_board?' do
    context 'when the square is on the board' do
      it 'returns true' do
        on_board_or_not = human_00.send(:on_board?, [0, 2])
        expect(on_board_or_not).to eq(true)
      end
      it 'returns true' do
        on_board_or_not = human_00.send(:on_board?, [4, 4])
        expect(on_board_or_not).to eq(true)
      end
    end
    context 'when the square is not on the board' do
      it 'returns false' do
        on_board_or_not = human_00.send(:on_board?, [-1, -1])
        expect(on_board_or_not).to eq(false)
      end
      it 'returns false' do
        on_board_or_not = human_00.send(:on_board?, [9, 10])
        expect(on_board_or_not).to eq(false)
      end
    end
  end
  describe '#number_of_squares_away' do
    context 'when it is one square away' do
      it 'returns 1' do
        number_of_squares = human_00.send(:number_of_squares_away, [0, 1])
        expect(number_of_squares).to eq(1)
      end
      it 'returns 1' do
        number_of_squares = human_00.send(:number_of_squares_away, [-1, 1])
        expect(number_of_squares).to eq(1)
      end
    end
    context 'when it is two squares away' do
      it 'returns 2' do
        number_of_squares = human_00.send(:number_of_squares_away, [2, 0])
        expect(number_of_squares).to eq(2)
      end
      it 'returns 2' do
        number_of_squares = human_00.send(:number_of_squares_away, [-2, 2])
        expect(number_of_squares).to eq(2)
      end
    end
  end
  describe '#valid moves' do
    context 'when it is a human at [0, 0] with no other piece on the board' do
      xit 'returns the valid moves' do
        valid_move_list = human_00.send(:valid_moves)
        expect(valid_move_list).to eq([[0, 1], [1, 0], [1, 1]])
      end
    end
    context 'when it is a human at [1, 2] with no other piece on the board' do
      xit 'returns the valid moves' do
        valid_move_list = human_12.send(:valid_moves)
        expect(valid_move_list).to eq([[0, 1], [0, 2], [0, 3], [1, 1], [1, 3],
                                       [2, 1], [2, 2], [2, 3]])
      end
    end
    context 'when it is a human at [7, 5] with no other piece on the board' do
      xit 'returns the valid moves' do
        valid_move_list = human_75.send(:valid_moves)
        expect(valid_move_list).to eq([[6, 4], [6, 5], [6, 6], [7, 4], [7, 6]])
      end
    end
    context 'when it is a human at [7, 7] with no other piece on the board' do
      xit 'returns the valid moves' do
        valid_move_list = human_77.send(:valid_moves)
        expect(valid_move_list).to eq([[6, 6], [6, 7], [7, 6]])
      end
    end
    context 'when it is a worm at [0, 0] with no other piece on the board
             and last move [-1, 0]' do
      xit 'returns the valid moves' do
        valid_move_list = worm_00_n10.send(:valid_moves)
        expect(valid_move_list).to eq([[0, 1], [0, 2], [1, 1], [2, 2]])
      end
    end
    context 'when it is a worm at [1, 2] with no other piece on the board
             and last move [-1, -1]' do
      xit 'returns the valid moves' do
        valid_move_list = worm_12_n1n1.send(:valid_moves)
        expect(valid_move_list).to eq([[0, 2], [0, 3], [1, 0], [1, 1], [1, 3], [1, 4],
                                       [2, 1], [2, 2], [3, 0], [3, 2]])
      end
    end
    context 'when it is a worm at [4, 4] with no other piece on the board
             and last move [-2, 2]' do
      xit 'returns the valid moves' do
        valid_move_list = worm_44_n22.send(:valid_moves)
        expect(valid_move_list).to eq([[2, 2], [2, 4], [3, 3], [3, 4], [4, 2], [4, 3],
                                       [4, 5], [4, 6], [5, 4], [5, 5], [6, 4], [6, 6]])
      end
    end
    context 'when it is a worm at [7, 5] with no other piece on the board
             and last move [1, 0]' do
      xit 'returns the valid moves' do
        valid_move_list = worm_75_10.send(:valid_moves)
        expect(valid_move_list).to eq([[5, 3], [5, 7], [6, 4], [6, 6], [7, 3],
                                       [7, 4], [7, 6], [7, 7]])
      end
    end
    context 'when it is a worm at [7, 7] with no other piece on the board
             and last move [-1, -1]' do
      xit 'returns the valid moves' do
        valid_move_list = worm_77_n1n1.send(:valid_moves)
        expect(valid_move_list).to eq([[5, 7], [6, 7], [7, 5], [7, 6]])
      end
    end
  end
end
