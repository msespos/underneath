class AddWormPlayerIdToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :worm_player_id, :uuid
  end
end
