class AddGameIdToHumans < ActiveRecord::Migration[6.1]
  def change
    add_column :humans, :game_id, :bigint
  end
end
