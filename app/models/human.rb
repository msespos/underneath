class Human < Piece
  belongs_to :game

  def move(x, y)
    self.x_position += x
    self.y_position += y
  end

  def print_label
    'H'
  end

  def valid_move?(start_square, finish_square)
    on_board?(start_square) && on_board?(finish_square) &&
    n_squares_away?(start_square, finish_square, 1)
  end
end
