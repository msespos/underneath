class Piece < ApplicationRecord
  self.abstract_class = true

  def on_board?(square)
    (0..Game::BOARD_SIZE - 1).include?(square[0]) &&
    (0..Game::BOARD_SIZE - 1).include?(square[1])
  end

  def number_of_squares_away(v)
    # use distance formula and rounding to return 1 or 2 given v

    # xd = (start_square[0] - finish_square[0]).abs
    # yd = (start_square[1] - finish_square[1]).abs
    # xd == n && yd == 0 || xd == 0 && yd == n || xd == n && yd == n
  end
end
