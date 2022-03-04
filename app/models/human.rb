class Human < ApplicationRecord
  belongs_to :game

  def move(x, y)
    self.x_position += x
    self.y_position += y
  end

  def on_board?
    (0..7).include?(x_position) && (0..7).include?(y_position)
  end
end
