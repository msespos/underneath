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
    start_and_finish_on_board?(v) && queens_move?(v) &&
    (number_of_squares_away(v) == 1 || number_of_squares_away(v) == 2) &&
    (!same_direction_as_last_move?(v) && !opposite_direction_as_last_move?(v) ||
    last_move_x_direction == 0 && last_move_y_direction == 0)
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

  def target_square_not_a_rock?(v)
    Card.where(game_id: game.id).each do |c|
      if x_position + v[0] == c.x_position && y_position + v[1] == c.y_position &&
        c.card_type == 'rock'
        return false
      end
    end
    true
  end

  def target_square_not_an_active_bomb?(v)
    Card.where(game_id: game.id).each do |c|
      if x_position + v[0] == c.x_position && y_position + v[1] == c.y_position &&
        c.card_type == 'bomb' && c.face_up == true
        return false
      end
    end
    true
  end
end
