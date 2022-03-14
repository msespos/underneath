class Game < ApplicationRecord
  has_one :worm, dependent: :destroy
  has_many :humans, dependent: :destroy
  has_many :cards, dependent: :destroy
  include Printable

  BOARD_SIZE = 8.freeze

  def valid_human_move?(start, finish)
    # starts on board
    # finishes on board
    # start space has human, it is the humans' turn, and
      # finish space is a human move away and is not occupied by a human
  end

  def valid_worm_move?(start, finish)
    # starts on board
    # finishes on board
    # start space has worm, it is the worm's turn,
      # and finish space is a worm move away and is not a rock
  end

  def on_board?(square)
  end

  def human_move_away?(start, finish)
  end

  def worm_move_away?(start, finish)
  end
end
