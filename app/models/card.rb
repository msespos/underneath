class Card < ApplicationRecord
  belongs_to :game

  def print_label
    'C'
  end
end
