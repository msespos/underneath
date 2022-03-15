class Worm < Piece
  belongs_to :game

  def print_label
    'W'
  end

  def valid_move?(start_square, finish_square)
    on_board?(start_square) && on_board?(finish_square) &&
    n_squares_away?(start_square, finish_square, 1) ||
    n_squares_away?(start_square, finish_square, 2)
  end
end
