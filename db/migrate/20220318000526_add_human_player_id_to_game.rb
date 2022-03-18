class AddHumanPlayerIdToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :human_player_id, :uuid
  end
end
