class Worm < Piece
  belongs_to :game

  def print_label
    'W'
  end

  def valid_move?(start_square, finish_square)
    on_board?(start_square) && on_board?(finish_square) &&
    (n_squares_away?(start_square, finish_square, 1) ||
    n_squares_away?(start_square, finish_square, 2)) &&
    !same_direction_as_last_move?(start_square, finish_square) &&
    !opposite_direction_as_last_move?(start_square, finish_square)
  end

  def same_direction_as_last_move?(start_square, finish_square)
  end

  def opposite_direction_as_last_move?(start_square, finish_square)
  end

  def difference_vector(start_square, finish_square)
    [finish_square[0] - start_square[0], finish_square[1] - start_square[1]]
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
