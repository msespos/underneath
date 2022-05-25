require 'rails_helper'

RSpec.describe Piece, type: :model do
  subject(:game1) { Game.new(id: 1) }
  subject(:human1) { Human.new(x_position: 0, y_position: 0) }
  subject(:human2) { Human.new(x_position: 1, y_position: 2) }
  subject(:human3) { Human.new(x_position: 7, y_position: 5) }
  subject(:human4) { Human.new(x_position: 7, y_position: 7) }
  subject(:active_bomb1) { ActiveBomb.new(x_position: 5, y_position: 7) }
  subject(:worm1) { Worm.new(x_position: 7, y_position: 7,
                             last_move_x_direction: nil,
                             last_move_y_direction: nil) }
  subject(:worm2) { Worm.new(x_position: 0, y_position: 0,
                             last_move_x_direction: -1,
                             last_move_y_direction: 0) }
  subject(:worm3) { Worm.new(x_position: 1, y_position: 2,
                             last_move_x_direction: -1,
                             last_move_y_direction: -1) }
  subject(:worm4) { Worm.new(x_position: 4, y_position: 4,
                             last_move_x_direction: -2,
                             last_move_y_direction: 2) }
  subject(:worm5) { Worm.new(x_position: 7, y_position: 5,
                             last_move_x_direction: 1,
                             last_move_y_direction: 0) }
  subject(:worm6) { Worm.new(x_position: 7, y_position: 7,
                             last_move_x_direction: -1,
                             last_move_y_direction: -1) }
  describe '#on_board?' do
    context 'when the square is on the board' do
      it 'returns true' do
        on_board_or_not = human1.send(:on_board?, [0, 2])
        expect(on_board_or_not).to eq(true)
      end
      it 'returns true' do
        on_board_or_not = human1.send(:on_board?, [4, 4])
        expect(on_board_or_not).to eq(true)
      end
    end
    context 'when the square is not on the board' do
      it 'returns false' do
        on_board_or_not = human1.send(:on_board?, [-1, -1])
        expect(on_board_or_not).to eq(false)
      end
      it 'returns false' do
        on_board_or_not = human1.send(:on_board?, [9, 10])
        expect(on_board_or_not).to eq(false)
      end
    end
  end
  describe '#number_of_king_moves_away' do
    context 'when it is one move away' do
      it 'returns 1' do
        number_of_king_moves = human1.send(:number_of_king_moves_away, [0, 1])
        expect(number_of_king_moves).to eq(1)
      end
      it 'returns 1' do
        number_of_king_moves = human1.send(:number_of_king_moves_away, [-1, 1])
        expect(number_of_king_moves).to eq(1)
      end
    end
    context 'when it is two moves away' do
      it 'returns 2' do
        number_of_king_moves = human1.send(:number_of_king_moves_away, [2, 0])
        expect(number_of_king_moves).to eq(2)
      end
      it 'returns 2' do
        number_of_king_moves = human1.send(:number_of_king_moves_away, [-2, 2])
        expect(number_of_king_moves).to eq(2)
      end
    end
  end
  describe '#valid moves' do
    context 'when it is a human at [0, 0] with no other piece on the board' do
      xit 'returns the valid moves' do
        valid_move_list = human1.send(:valid_moves)
        expect(valid_move_list).to eq([[0, 1], [1, 0], [1, 1]])
      end
    end
    context 'when it is a human at [1, 2] with no other piece on the board' do
      xit 'returns the valid moves' do
        valid_move_list = human2.send(:valid_moves)
        expect(valid_move_list).to eq([[0, 1], [0, 2], [0, 3], [1, 1], [1, 3],
                                       [2, 1], [2, 2], [2, 3]])
      end
    end
    context 'when it is a human at [7, 5] with no other piece on the board' do
      xit 'returns the valid moves' do
        valid_move_list = human3.send(:valid_moves)
        expect(valid_move_list).to eq([[6, 4], [6, 5], [6, 6], [7, 4], [7, 6]])
      end
    end
    context 'when it is a human at [7, 7] with no other piece on the board' do
      xit 'returns the valid moves' do
        valid_move_list = human4.send(:valid_moves)
        expect(valid_move_list).to eq([[6, 6], [6, 7], [7, 6]])
      end
    end
    context 'when it is a worm at [0, 0] with no other piece on the board
             and last move [-1, 0]' do
      xit 'returns the valid moves' do
        valid_move_list = worm2.send(:valid_moves)
        expect(valid_move_list).to eq([[0, 1], [0, 2], [1, 1], [2, 2]])
      end
    end
    context 'when it is a worm at [1, 2] with no other piece on the board
             and last move [-1, -1]' do
      xit 'returns the valid moves' do
        valid_move_list = worm3.send(:valid_moves)
        expect(valid_move_list).to eq([[0, 2], [0, 3], [1, 0], [1, 1], [1, 3], [1, 4],
                                       [2, 1], [2, 2], [3, 0], [3, 2]])
      end
    end
    context 'when it is a worm at [4, 4] with no other piece on the board
             and last move [-2, 2]' do
      xit 'returns the valid moves' do
        valid_move_list = worm4.send(:valid_moves)
        expect(valid_move_list).to eq([[2, 2], [2, 4], [3, 3], [3, 4], [4, 2], [4, 3],
                                       [4, 5], [4, 6], [5, 4], [5, 5], [6, 4], [6, 6]])
      end
    end
    context 'when it is a worm at [7, 5] with no other piece on the board
             and last move [1, 0]' do
      xit 'returns the valid moves' do
        valid_move_list = worm5.send(:valid_moves)
        expect(valid_move_list).to eq([[5, 3], [5, 7], [6, 4], [6, 6], [7, 3],
                                       [7, 4], [7, 6], [7, 7]])
      end
    end
    context 'when it is a worm at [7, 7] with no other piece on the board
             and last move [-1, -1]' do
      xit 'returns the valid moves' do
        valid_move_list = worm6.send(:valid_moves)
        expect(valid_move_list).to eq([[5, 7], [6, 7], [7, 5], [7, 6]])
      end
    end
  end
  describe '#active_bomb_on?' do
    before do
      game1.active_bombs << active_bomb1
    end

    context 'when the target square is an active bomb' do
      it 'returns true' do
        allow(worm1).to receive(:game).and_return(game1)
        an_active_bomb = worm1.send(:active_bomb_on?, [5, 7])
        expect(an_active_bomb).to eq(true)
      end
    end
    context 'when the target square is not an active bomb' do
      it 'returns false' do
        allow(worm1).to receive(:game).and_return(game1)
        an_active_bomb = worm1.send(:active_bomb_on?, [6, 7])
        expect(an_active_bomb).to eq(false)
      end
    end
  end
end
