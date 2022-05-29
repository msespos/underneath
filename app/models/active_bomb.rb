class ActiveBomb < ApplicationRecord
  belongs_to :game

  def print_label(view = :humans)
    'B'
  end
end
