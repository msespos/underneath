class Game < ApplicationRecord
  has_one :worm_piece, dependent: :destroy
  has_many :humans, dependent: :destroy
  has_many :cards, dependent: :destroy
end
