class Game < ApplicationRecord
  has_one :worm_piece
  has_many :humans
  has_many :cards
end
