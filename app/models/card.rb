require 'matrix'

class Card < ApplicationRecord
  belongs_to :game

  # not tested; just printing
  def print_label(view = :humans)
    if type == 'Rock' && (self.face_up == true && !human_on_card? || view == :worm)
      'R'
    elsif type == 'Rock' && self.face_up == true
      '®'
    else
      'C'
    end
  end

  # tested
  def human_on_card?
    game.humans.detect { |h| h.x_position == x_position && h.y_position == y_position }
  end

  # not tested; just writing data
  def reveal
    if type == 'Rock'
      self.face_up = true
      game.last_revealed_card_message = 'Rock revealed'
    elsif type == 'Bomb'
      game.humans_bombs += 1
      self.x_position = nil
      self.y_position = nil
      game.last_revealed_card_message = 'Bomb added to inventory and card discarded'
    else
      self.x_position = nil
      self.y_position = nil
      game.last_revealed_card_message = 'Blank revealed and discarded'
    end
    self.save
    game.save
  end
end
