class Worm < Piece
  belongs_to :game

  def print_label
    'W'
  end

  def valid_move?(v)
    valid_move_geometry?(v) && target_square_not_a_rock?(v) &&
    target_square_not_an_active_bomb?(v)
  end

  def valid_move_geometry?(v)
    start_and_finish_on_board?(v) &&
    queens_move?(v) &&
    number_of_king_moves_away(v).in?([1, 2]) &&
    (last_move.nil? ||
     !same_direction?(v, last_move) && !opposite_direction?(v, last_move))
  end

  def queens_move?(v)
    v[0] == 0 && [-2, -1, 1, 2].include?(v[1]) ||
    v[1] == 0 && [-2, -1, 1, 2].include?(v[0]) ||
    [-2, -1, 1, 2].include?(v[0]) && v[0].abs == v[1].abs
  end

  def last_move
    return nil if last_move_x_direction.nil?

    [last_move_x_direction, last_move_y_direction]
  end

  def same_direction?(v, w)
    angle(v) == angle(w)
  end

  def opposite_direction?(v, w)
    (angle(v) - angle(w)).abs == 180
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

  def target_square_not_a_rock?(v)
    game.cards.each do |c|
      if x_position + v[0] == c.x_position && y_position + v[1] == c.y_position &&
        c.type == 'Rock'
        return false
      end
    end
    true
  end

  def target_square_not_an_active_bomb?(v)
    game.active_bombs.each do |b|
      if x_position + v[0] == b.x_position && y_position + v[1] == b.y_position
        return false
      end
    end
    true
  end
end
