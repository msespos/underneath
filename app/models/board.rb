class Board < ApplicationRecord
  has_one :worm_token
  has_many :human_tokens
  has_many :cards
end
