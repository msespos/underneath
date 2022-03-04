class Human < ApplicationRecord
  belongs_to :game

  def move(x, y)
    self.x_position += x
    self.y_position += y
  end
end
