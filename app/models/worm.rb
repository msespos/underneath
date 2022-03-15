class Worm < Piece
  belongs_to :game

  def print_label
    'W'
  end

  def valid_move?(start_square, finish_square)
    on_board?(start_square) && on_board?(finish_square) &&
    (one_square_away?(start_square, finish_square) ||
     two_squares_away?(start_square, finish_square)) &&
    !same_direction_as_last_move(start_square, finish_square, last_move) &&
    !opposite_direction_as_last_move(start_square, finish_square, last_move)
  end
end
