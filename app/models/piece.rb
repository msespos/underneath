class Piece < ApplicationRecord
  self.abstract_class = true

  def validate_and_move(v)
    move(v) if valid_move?(v)
  end

  def move(v)
    self.x_position += v[0]
    self.y_position += v[1]
  end

  def start_and_finish_on_board?(v)
    on_board?([x_position, y_position]) &&
    on_board?([x_position + v[0], y_position + v[1]])
  end

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

  def valid_moves_from(start_square)
    (0..Game::BOARD_SIZE).each do |x|
      (0..Game::BOARD_SIZE).each do |y|
        puts x.to_s + ', ' + y.to_s if valid_move?([x - start_square[0], y - start_square[1]])
      end
    end
  end
end
