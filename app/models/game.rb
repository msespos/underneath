class Game < ApplicationRecord
  has_one :worm, dependent: :destroy
  has_many :humans, dependent: :destroy
  has_many :cards, dependent: :destroy
  include Printable

  BOARD_SIZE = 8.freeze

  def set_up
    set_up_humans
    set_up_worm
    set_up_cards
  end

  def all_pieces
    humans + cards + (worm ? [worm] : [])
  end

  def set_up_humans
    [[1, 0, 1], [2, 0, 3], [3, 1, 0], [4, 3, 0]].each do |p|
      humans.create({ alive: true, x_position: p[1], y_position: p[2],
                       play_order: p[0], game_id: self.id })
    end
  end

  def set_up_worm
    create_worm({ alive: true, x_position: 7, y_position: 7, game_id: self.id })
  end

  def set_up_cards
  end

  def reset
    self.turn = 1
    self.phase = "human 1"
    self.save
    all_pieces.map { |i| i.destroy }
  end
end
