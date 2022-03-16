class Piece < ApplicationRecord
  self.abstract_class = true

  def on_board?(square)
    (0..Game::BOARD_SIZE - 1).include?(square[0]) &&
    (0..Game::BOARD_SIZE - 1).include?(square[1])
  end

  def n_squares_away?(start_square, finish_square, n)
    xd = (start_square[0] - finish_square[0]).abs
    yd = (start_square[1] - finish_square[1]).abs
    xd == n && yd == 0 || xd == 0 && yd == n || xd == n && yd == n
  end

  def move_direction(move)
    [move[1][0] - move[0][0], move[1][1] - move[0][1]]
  end
end
