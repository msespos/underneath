module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_player_id

    def connect
      self.current_player_id = find_player_id
    end

    protected

    def find_player_id
      cookies['player_id']
    end

  end
end