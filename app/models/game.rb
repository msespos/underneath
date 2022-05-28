require 'matrix'

class Game < ApplicationRecord
  has_one :worm, dependent: :destroy
  has_many :humans, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :active_bombs, dependent: :destroy
  include Printable

  BOARD_SIZE = 8.freeze

  # not tested
  def all_pieces
    humans + cards + (worm ? [worm] : []) + active_bombs
  end

  # not tested
  def rocks
    cards.where(type: "Rock")
  end

  # tested
  def set_up
    reset
    set_up_humans
    set_up_worm
    set_up_cards
  end

  # not tested - almost identical to set_up
  def set_up_no_cards
    reset
    set_up_humans
    set_up_worm
  end

  # not tested - just writing data
  def reset
    self.turn = 1
    self.phase = "human 1"
    self.humans_bombs = 0
    self.last_revealed_card_message = nil
    self.status = 'Game in play'
    self.save
    all_pieces.map { |i| i.destroy }
  end

  # tested
  def set_up_humans
    [[1, 0, 1], [2, 0, 3], [3, 1, 0], [4, 3, 0]].each do |p|
      humans.create({ alive: true,
                      play_order: p[0],
                      x_position: p[1],
                      y_position: p[2],
                      game_id: self.id })
    end
  end

  # tested
  def set_up_worm
    create_worm({ alive: true,
                  x_position: 7,
                  y_position: 7,
                  game_id: self.id })
  end

  # still need to test that card types are created correctly (how to do this?)
  def set_up_cards
    card_positions = (0..7).to_a.product((0..7).to_a)
    card_positions = card_positions -
                     [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4],
                      [1, 0], [1, 1], [1, 3], [2, 0], [3, 0], [3, 1], [4, 0],
                      [5, 5], [5, 7], [6, 6], [6, 7], [7, 5], [7, 6], [7, 7]]
    all_card_types = ['Blank'] * 12 + ['Bomb'] * 12 + ['Rock'] * 21
    shuffled_card_types = all_card_types.shuffle
    (0..44).each do |i|
      cards.create({ x_position: card_positions[i][0],
                     y_position: card_positions[i][1],
                     type: shuffled_card_types[i],
                     face_up: false })
    end
  end

  def active_piece
    if phase == "worm"
      worm
    else
      human_by_phase
    end
  end

  def humans_left
    humans.where.not(x_position: nil).count
  end

  # need to test
  def human_by_phase
    humans.where(play_order: phase.split(' ')[-1].to_i).first
  end

  def active_piece_side
    phase == 'worm' ? 'worm' : 'humans'
  end

  # need to test
  def play_turn(type, v)
    reset_messages
    if type == 'place bomb' && phase == 'worm'
      raise StandardError, 'Worm cannot place bomb'
    end
    if type == 'move'
      move(v)
      item_on_square(cards, active_piece.position)&.reveal unless phase == 'worm'
      item_on_square(humans, worm.position)&.die!
    elsif type == 'place bomb'
      place_bomb(v)
      bomb_emergent_worm(v)
    elsif type == 'forfeit piece'
      if active_piece.valid_moves.empty?
        active_piece.die!
      else
        raise StandardError, 'Piece still has moves available'
      end
    else
      raise StandardError, 'Incorrect type'
    end
    set_status
    advance_phase
  end

  def reset_messages
    self.worm_message = nil
    self.humans_message = nil
    self.save
  end

  def move(v)
    if active_piece.valid_move?(v, active_piece.position, active_piece.last_move)
      active_piece.move(v)
    else
      raise StandardError, 'Invalid move'
    end
  end

  # need to test
  def item_on_square(items, position)
    items.detect do |i|
      i.x_position == position[0] && i.y_position == position[1]
    end
  end

  def place_bomb(v)
    if active_piece.valid_bomb_placement?(v)
      active_piece.place_bomb(v)
    else
      raise StandardError, 'Invalid bomb placement'
    end
  end

  # need to test
  def bomb_emergent_worm(v)
    if worm.emergent == true &&
      active_piece.x_position + v[0] == worm.x_position &&
      active_piece.y_position + v[1] == worm.y_position
      worm.die!
    end
  end

  def set_status
    if worm.alive == false
      self.status = 'Humans win'
    # fix verbose naming
    elsif any_human_inaccessible_and_not_on_a_rock?
      self.status = 'Humans win'
    elsif all_humans_dead?
      self.status = 'Worm wins'
    else
      self.status = 'Game in play'
    end
    self.save
  end

  # fix verbose naming
  def any_human_inaccessible_and_not_on_a_rock?
    humans.any? { |h| h.inaccessible? && !h.on_a_rock? }
  end

  # need to test
  def all_humans_dead?
    humans.all? { |h| h.alive == false }
  end

  def advance_phase
    phases = ['human 1', 'human 2', 'human 3', 'human 4', 'worm']
    simple_advance_phase(phases)
    while human_by_phase && !human_by_phase.alive
      simple_advance_phase(phases)
    end
    self.save
  end

  # need to test
  def simple_advance_phase(phases)
    idx = phases.index(phase)
    if idx == phases.length - 1
      self.phase = phases[0]
      self.turn += 1
    else
      self.phase = phases[idx + 1]
    end
  end

  def humans_view_state
    valid_moves = active_piece.valid_moves if active_piece_side == 'humans'
    local_active_piece = active_piece if active_piece_side == 'humans'
    valid_bomb_placements = active_piece.valid_bomb_placements if active_piece_side == 'humans'
    if on_worm_emergence_turn?
      worms_x_position = worm.x_position
      worms_y_position = worm.y_position
    else
      worms_x_position = 'hidden'
      worms_y_position = 'hidden'
    end
    { game: self.as_json.except('worm_message'),
      humans: humans,
      active_bombs: active_bombs,
      face_up_cards: face_up_cards_locations,
      face_down_cards: face_down_cards_locations,
      active_piece: local_active_piece,
      valid_moves: valid_moves,
      valid_bomb_placements: valid_bomb_placements,
      humans_message: humans_message,
      worms_x_position: worms_x_position,
      worms_y_position: worms_y_position,
      next_worm_emergence_turn: next_worm_emergence_turn }
  end

  def face_up_cards_locations
    cards.where(face_up: true).map do |c|
      { x_position: c.x_position,
        y_position: c.y_position,
        type: c.type }
    end
  end

  def face_down_cards_locations
    cards.where(face_up: false).map do |c|
      { x_position: c.x_position,
        y_position: c.y_position }
    end
  end

  def worms_view_state
    valid_moves = active_piece.valid_moves if active_piece_side == 'worm'
    local_active_piece = active_piece if active_piece_side == 'worm'
    { game: self.as_json.except(*['humans_bombs',
                                  'last_revealed_card_message',
                                  'humans_message']),
      worm: worm,
      active_bombs: active_bombs,
      rocks: rocks_locations,
      active_piece: local_active_piece,
      valid_moves: valid_moves,
      worm_message: worm_message,
      humans_left: humans_left,
      next_worm_emergence_turn: next_worm_emergence_turn }
  end

  def rocks_locations
    cards.where(type: 'Rock').map do |c|
      { x_position: c.x_position,
        y_position: c.y_position }
    end
  end

  # need to test
  def next_worm_emergence_turn
    turn - turn % 4 + 4
  end

  def on_worm_emergence_turn?
    turn % 4 == 0
  end
end
