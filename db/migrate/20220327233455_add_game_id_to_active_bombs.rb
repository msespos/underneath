class AddGameIdToActiveBombs < ActiveRecord::Migration[6.1]
  def change
    add_column :active_bombs, :game_id, :bigint
  end
end
