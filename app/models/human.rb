require 'matrix'

class Human < Piece
  belongs_to :game

  def print_label
    'H'
  end

  def place_bomb(v)
    ActiveBomb.create({ x_position: x_position + v[0],
                        y_position: y_position + v[1],
                        game_id: game.id })
    game.humans_bombs -= 1
  end

  def valid_bomb_placement?(v)
    game.humans_bombs > 0 &&
    valid_move?(v) &&
    !card?(v)
  end

  def valid_move?(v)
    valid_move_geometry?(v) &&
    !human?(v) &&
    !active_bomb_on?(self.position + Vector.elements(v)) &&
    !moving_from_rock_to_rock?(v)
  end

  def valid_move_geometry?(v)
    start_and_finish_on_board?(v) &&
    kings_move?(v) &&
    number_of_king_moves_away(v) == 1
  end

  def kings_move?(v)
    v[0] == 0 && [-1, 1].include?(v[1]) ||
    v[1] == 0 && [-1, 1].include?(v[0]) ||
    [-1, 1].include?(v[0]) && v[0].abs == v[1].abs
  end

  def human?(v)
    game.humans.each do |h|
      if x_position + v[0] == h.x_position && y_position + v[1] == h.y_position
        return true
      end
    end
    false
  end

  def moving_from_rock_to_rock?(v)
    rocks = game.cards.where(type: 'Rock', face_up: true)
    game.item_on_square(rocks, position) &&
    game.item_on_square(rocks, position + Vector.elements(v))
  end

  def card?(v)
    game.cards.each do |c|
      if x_position + v[0] == c.x_position && y_position + v[1] == c.y_position
        return true
      end
    end
    false
  end

  def die!
    self.alive = false
    self.x_position = nil
    self.y_position = nil
    self.save
    game.worm_message = 'You just ate a human'
    game.human_message = 'One of your humans was just eaten'
    game.save
  end
end
