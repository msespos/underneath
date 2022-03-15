class Worm < Piece
  belongs_to :game

  def print_label
    'W'
  end

  def one_move_away?(a, b)
    (x_distance(a, b) == 1 || x_distance(a, b) == 2) && y_distance(a, b) == 0 ||
    x_distance(a, b) == 0 && (y_distance(a, b) == 1 || y_distance(a, b) == 2) ||
    x_distance(a, b) == 1 && y_distance(a, b) == 1 ||
    x_distance(a, b) == 2 && y_distance(a, b) == 2
  end
end
