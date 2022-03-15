class Piece < ApplicationRecord
  self.abstract_class = true

  def on_board?(square)
    (0..Game::BOARD_SIZE - 1).include?(square[0]) &&
    (0..Game::BOARD_SIZE - 1).include?(square[1])
  end

  def x_distance(start_square, finish_square)
    (start_square[0] - finish_square[0]).abs
  end

  def y_distance(start_square, finish_square)
    (start_square[1] - finish_square[1]).abs
  end

  def one_square_away?(a, b)
    x_distance(a, b) == 1 && y_distance(a, b) == 0 ||
    x_distance(a, b) == 0 && y_distance(a, b) == 1 ||
    x_distance(a, b) == 1 && y_distance(a, b) == 1
  end

  def two_squares_away?(a, b)
    x_distance(a, b) == 2 && y_distance(a, b) == 0 ||
    x_distance(a, b) == 0 && y_distance(a, b) == 2 ||
    x_distance(a, b) == 2 && y_distance(a, b) == 2
  end
end