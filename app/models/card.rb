require 'matrix'

class Card < ApplicationRecord
  belongs_to :game

  def print_label(worm_view = false)
    if type == 'Rock' && self.face_up == true && human_on_card?
      '®'
    elsif type == 'Rock' && (self.face_up == true || worm_view = true)
      'R'
    else
      'C'
    end
  end

  def human_on_card?
    game.humans.detect { |h| h.x_position == x_position && h.y_position == y_position }
  end

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
