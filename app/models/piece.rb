class Piece < ApplicationRecord
  self.abstract_class = true

  def on_board?(square)
    (0..Game::BOARD_SIZE - 1).include?(square[0]) &&
    (0..Game::BOARD_SIZE - 1).include?(square[1])
  end

  def number_of_squares_away(v)
    d = Math.sqrt(v[0] ** 2 + v[1] ** 2)
    move_d = if d < 2
               1
             else
               2
             end
  end
end
