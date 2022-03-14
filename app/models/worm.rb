class Worm < ApplicationRecord
  belongs_to :game

  def print_label
    'W'
  end
end
