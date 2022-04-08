class Game < ApplicationRecord
  has_one :worm, dependent: :destroy
  has_many :humans, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :active_bombs, dependent: :destroy
  include Printable

  BOARD_SIZE = 8.freeze

  def all_pieces
    humans + cards + (worm ? [worm] : []) + active_bombs
  end

  def set_up
    reset
    set_up_humans
    set_up_worm
    set_up_cards
  end

  def reset
    self.turn = 1
    self.phase = "human 1"
    self.humans_bombs = 0
    self.last_revealed_card_message = nil
    self.save
    all_pieces.map { |i| i.destroy }
  end

  def set_up_humans
    [[1, 0, 1], [2, 0, 3], [3, 1, 0], [4, 3, 0]].each do |p|
      humans.create({ alive: true, x_position: p[1], y_position: p[2],
                      play_order: p[0], game_id: self.id })
    end
  end

  def set_up_worm
    create_worm({ alive: true, x_position: 7, y_position: 7,
                  game_id: self.id })
  end

  def set_up_cards
    card_positions = []
    # set y-coordinates of all squares on board
    (0..63).each do |i|
      card_positions[i] = [0, i % 8]
    end
    # set x-coordinates of all squares on board
    card_positions.each_with_index do |_, i|
      card_positions[i][0] = (i / 8).floor
    end
    # remove non-card squares
    card_positions = card_positions -
                     [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4],
                      [1, 0], [1, 1], [1, 3], [2, 0], [3, 0], [3, 1], [4, 0],
                      [6, 6], [6, 7], [7, 6], [7, 7]]
    # create and shuffle list of card types
    all_card_types = Array.new(12) { 'Blank' } + Array.new(12) { 'Bomb' } +
                     Array.new(24) { 'Rock' }
    shuffled_card_types = all_card_types.shuffle
    # create cards from card positions and shuffled card types
    (0..47).each do |i|
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

  def human_by_phase
    humans.where(play_order: phase.split(' ')[-1].to_i).first
  end

  def active_piece_side
    phase == 'worm' ? 'worm' : 'humans'
  end

  def play_turn(type, v)
    if type == 'place bomb' && phase == 'worm'
      raise StandardError, 'Worm cannot place bomb'
    end

    if type == 'move'
      move(v)
    elsif type == 'place bomb'
      place_bomb(v)
    else
      raise StandardError, 'Incorrect type'
    end

    item_on_square(cards, active_piece)&.reveal unless phase == 'worm'
    item_on_square(humans, worm)&.die!

    # still need to check win conditions here
    advance_phase
  end

  def move(v)
    if active_piece.valid_move?(v)
      active_piece.move(v)
    else
      raise StandardError, 'Invalid move'
    end
  end

  def place_bomb(v)
    if active_piece.valid_bomb_placement?(v)
      active_piece.place_bomb(v)
    else
      raise StandardError, 'Invalid bomb placement'
    end
  end

  def item_on_square(items, piece)
    items.detect do |i|
      i.x_position == piece.x_position && i.y_position == piece.y_position
    end
  end

  def humans_view_state
    valid_moves = active_piece.valid_moves if active_piece_side == 'humans'
    { humans: humans,
      active_bombs: active_bombs,
      face_up_cards: face_up_cards_locations,
      face_down_cards: face_down_cards_locations,
      active_piece: active_piece,
      valid_moves: valid_moves }
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
    { worm: worm,
      active_bombs: active_bombs,
      rocks: rocks_locations,
      active_piece: active_piece,
      valid_moves: valid_moves }
  end

  def rocks_locations
    cards.where(type: 'Rock').map do |c|
      { x_position: c.x_position,
        y_position: c.y_position }
    end
  end

  def advance_phase
    phases = ['human 1', 'human 2', 'human 3', 'human 4', 'worm']
    simple_advance_phase(phases)
    while human_by_phase && !human_by_phase.alive
      simple_advance_phase(phases)
    end
    self.save
  end

  def simple_advance_phase(phases)
    idx = phases.index(phase)
    if idx == phases.length - 1
      self.phase = phases[0]
      self.turn += 1
    else
      self.phase = phases[idx + 1]
    end
  end
end
