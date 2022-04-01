class Card < ApplicationRecord
  belongs_to :game

  def print_label
    'C'
  end

  def reveal
    # ADD LAST REVEALED CARD MESSAGE FIELD TO GAME
    if type == 'Rock'
      self.face_up = true
      game.last_revealed_card_message = 'Rock revealed'
    elsif type == 'Bomb'
      game.humans_bombs += 1
      self.x_position = nil
      self.y_position = nil
      game.last_revealed_card_message = 'Bomb added to inventory'
    else
      self.x_position = nil
      self.y_position = nil
      game.last_revealed_card_message = 'Blank revealed'
    end
    self.save
    game.save
  end
end
