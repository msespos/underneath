class Worm < Piece
  belongs_to :game

  def print_label
    'W'
  end

  def valid_move?(start_square, finish_square)
    on_board?(start_square) && on_board?(finish_square) &&
    n_squares_away?(start_square, finish_square, 1) ||
    n_squares_away?(start_square, finish_square, 2) &&
    !same_direction_as_last_move(start_square, finish_square) &&
    !opposite_direction_as_last_move(start_square, finish_square, last_move_direction)
  end

  def same_direction_as_last_move(start_square, finish_square)
    x_component(start_square, finish_square) == last_move_x_direction &&
    y_component(start_square, finish_square) == last_move_y_direction
  end

  def opposite_direction_as_last_move(start_square, finish_square)
    x_component(start_square, finish_square) == -1 * last_move_x_direction &&
    y_component(start_square, finish_square) == -1 * last_move_y_direction
  end

  def x_component(start_square, finish_square)
    finish_square[0] - start_square[0]
  end

  def y_component(start_square, finish_square)
    finish_square[1] - start_square[1]
  end
end
