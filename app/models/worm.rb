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

  def valid_move?(v)
    valid_move_geometry?(v) &&
    !rock_on?(self.position + Vector.elements(v)) &&
    !active_bomb_on?(self.position + Vector.elements(v))
  end

  def valid_move_geometry?(v)
    start_and_finish_on_board?(v) &&
    queens_move?(v) &&
    number_of_king_moves_away(v).in?([1, 2]) &&
    (last_move.nil? ||
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
end
