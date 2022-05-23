require 'matrix'

class Worm < Piece
  belongs_to :game

  def print_label
    'W'
  end

  def move(v)
    self.last_move_x_direction = v[0]
    self.last_move_y_direction = v[1]
    super(v)
  end

  def valid_move?(v, starting_square, last_move)
    return valid_move_geometry?(v, starting_square, last_move) &&
      !rock_on?(Vector[*starting_square] + Vector[*v]) &&
      !active_bomb_on?(Vector[*starting_square] + Vector[*v])
  end

  def valid_move_geometry?(v, starting_square, last_move)
    on_board?(starting_square) &&
    on_board?(Vector[*starting_square] + Vector[*v]) &&
    queens_move?(v) &&
    number_of_king_moves_away(v).in?([1, 2]) &&
    last_move_check_passes(v, last_move)
  end

  def last_move_check_passes(v, last_move)
    return (last_move.nil? ||
      !same_direction?(v, last_move) && !opposite_direction?(v, last_move))
  end

  def queens_move?(v)
    v[0] == 0 && v[1] != 0 ||
    v[1] == 0 && v[0] != 0 ||
    v[0] != 0 && v[0].abs == v[1].abs
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

  def rock_on?(square)
    game.cards.each do |c|
      if square[0] == c.x_position && square[1] == c.y_position && c.type == 'Rock'
        return true
      end
    end
    false
  end

  def humans_in_view
    humans_in_view = []
    game.humans.each do |h|
      humans_in_view << h if h.number_of_king_moves_away(h.position - position) <= 2
    end
    humans_in_view
  end

  def squares_in_view
    squares_in_view = []
    (-2..2).each do |x|
      (-2..2).each do |y|
        if on_board?([x_position + x, y_position + y])
          squares_in_view << [x_position + x, y_position + y]
        end
      end
    end
    squares_in_view
  end

  def alive_humans_count
    game.humans.count { |h| h.alive }
  end

  def accessible_squares
    # currently can generate a list of first and second level moves
    # from current worm position
    # need to continue creating lists of third level and beyond
    # keep building list until it stops growing
    accessible_squares = valid_moves_plus_directions
    valid_moves_plus_directions.each do |move_plus_direction|
      simulated_valid_moves_plus_directions(move_plus_direction).each do |s|
        accessible_squares << s
      end
    end
    accessible_squares
  end

  def valid_moves_plus_directions
    valid_moves.map do |move|
      move = [move, [move[0] - x_position, move[1] - y_position]]
    end
  end

  # overlaps logic with Piece#valid_moves; consider combining
  def simulated_valid_moves_plus_directions(move_plus_direction)
    valid_moves_plus_directions = []
    (0..Game::BOARD_SIZE - 1).each do |x|
      (0..Game::BOARD_SIZE - 1).each do |y|
        v = [x - move_plus_direction[0][0], y - move_plus_direction[0][1]]
        start = move_plus_direction[0]
        last_move = move_plus_direction[1]
        valid_moves_plus_directions << [[x, y], v] if valid_move?(v, start, last_move)
      end
    end
    valid_moves_plus_directions
  end

  def die!
    self.alive = false
    self.x_position = nil
    self.y_position = nil
    self.save
    game.worm_message = 'Your worm is dead'
    game.humans_message = 'You just killed the worm'
    game.save
  end
end
