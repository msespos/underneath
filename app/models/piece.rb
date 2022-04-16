require 'matrix'

class Piece < ApplicationRecord
  self.abstract_class = true

  def position
    Vector[x_position, y_position]
  end

  def validate_and_move(v)
    move(v) if valid_move?(v)
  end

  def move(v)
    self.x_position += v[0]
    self.y_position += v[1]
    self.save
  end

  def start_and_finish_on_board?(v)
    on_board?([x_position, y_position]) &&
    on_board?([x_position + v[0], y_position + v[1]])
  end

  def on_board?(square)
    (0..Game::BOARD_SIZE - 1).include?(square[0]) &&
    (0..Game::BOARD_SIZE - 1).include?(square[1])
  end

  def number_of_king_moves_away(v)
    v[0].abs > v[1].abs ? v[0].abs : v[1].abs
  end

  def valid_moves
    valid_moves = []
    (0..Game::BOARD_SIZE - 1).each do |x|
      (0..Game::BOARD_SIZE - 1).each do |y|
        valid_moves << [x, y] if valid_move?([x - x_position, y - y_position])
      end
    end
    valid_moves
  end

  def active_bomb?(v)
    game.active_bombs.each do |b|
      if x_position + v[0] == b.x_position && y_position + v[1] == b.y_position
        return true
      end
    end
    false
  end
end
