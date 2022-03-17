class Human < Piece
  belongs_to :game

  def move(x, y)
    self.x_position += x
    self.y_position += y
  end

  def print_label
    'H'
  end

  def valid_move?(v)
    on_board?(v[0]) && on_board?(v[1]) && kings_move?(v) &&
    number_of_squares_away(v) == 1
  end

  def kings_move?(v)
    v[0] == 0 && [-1, 1].include?(v[1]) || v[1] == 0 && [-1, 1].include?(v[0]) ||
    [-1, 1].include?(v[0]) && v[0].abs == v[1].abs
  end
end
