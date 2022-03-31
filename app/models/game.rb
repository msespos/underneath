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

  def humans_view_state
    { humans: humans, active_bombs: active_bombs, face_up_cards: face_up_cards_data,
      face_down_cards: face_down_cards_data }
  end

  def face_up_cards_data
    cards.where(face_up: true).map do |c|
      c = { x_position: c.x_position, y_position: c.y_position, type: c.type }
    end
  end

  def face_down_cards_data
    cards.where(face_up: false).map do |c|
      c = { x_position: c.x_position, y_position: c.y_position }
    end
  end

  def worms_view_state
    { active_bombs: active_bombs, rocks: rocks_data }
  end

  def rocks_data
    cards.where(type: 'Rock').map do |c|
      c = { x_position: c.x_position, y_position: c.y_position }
    end
  end

  def advance_phase
    phases = ['human 1', 'human 2', 'human 3', 'human 4', 'worm']
    idx = phases.index(phase)
    if idx == phases.length - 1
      phase = phases[0]
      turn += 1
    else
      phase = phases[idx + 1]
    end
  end
end
