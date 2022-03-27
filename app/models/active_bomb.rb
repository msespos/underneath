class ActiveBomb < ApplicationRecord
  belongs_to :game

  def print_label
    'B'
  end
end
