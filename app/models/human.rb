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
    target_square_not_a_card?(v)
  end

  def valid_move?(v)
    valid_move_geometry?(v) &&
    target_square_not_a_human?(v) &&
    target_square_not_an_active_bomb?(v)
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

  def target_square_not_a_human?(v)
    game.humans.each do |h|
      if x_position + v[0] == h.x_position && y_position + v[1] == h.y_position
        return false
      end
    end
    true
  end

  def target_square_not_a_card?(v)
    game.cards.each do |c|
      if x_position + v[0] == c.x_position && y_position + v[1] == c.y_position
        return false
      end
    end
    true
  end

  def die!
    self.alive = false
    self.x_position = nil
    self.y_position = nil
    self.save
  end
end
