class Game < ApplicationRecord
  has_one :worm, dependent: :destroy
  has_many :humans, dependent: :destroy
  has_many :cards, dependent: :destroy
  include Printable
end
