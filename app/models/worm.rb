class Worm < Piece
  belongs_to :game

  def print_label
    'W'
  end

  def valid_move?(v)
    on_board?(v[0]) && on_board?(v[1]) && queens_move?(v) &&
    (number_of_squares_away(v) == 1 || number_of_squares_away(v) == 2) &&
    !same_direction_as_last_move?(v) && !opposite_direction_as_last_move?(v)
  end

  def queens_move?(v)
    v[0] == 0 && [-2, -1, 1, 2].include?(v[1]) ||
    v[1] == 0 && [-2, -1, 1, 2].include?(v[0]) ||
    [-2, -1, 1, 2].include?(v[0]) && v[0].abs == v[1].abs
  end

  def same_direction_as_last_move?(v)
    angle(v) == angle([last_move_x_direction, last_move_y_direction])
  end

  def opposite_direction_as_last_move?(v)
    (angle(v) - angle([last_move_x_direction, last_move_y_direction])).abs == 180
  end

  def angle(v)
    if v[0] == 0
      if v[1] > 0
        return 90
      else
        return 270
      end
    elsif v[0] > 0
      if v[1] > 0
        return 45
      elsif v[1] == 0
        return 0
      else
        return 315
      end
    else
      if v[1] > 0
        return 135
      elsif v[1] == 0
        return 180
      else
        return 225
      end
    end
  end
end
