class Human < Piece
  belongs_to :game

  def move(x, y)
    self.x_position += x
    self.y_position += y
  end

  def print_label
    'H'
  end

  def one_move_away?(a, b)
    x_distance(a, b) == 1 && y_distance(a, b) == 0 ||
    x_distance(a, b) == 0 && y_distance(a, b) == 1 ||
    x_distance(a, b) == 1 && y_distance(a, b) == 1
  end
end
