class AddGameIdToCards < ActiveRecord::Migration[6.1]
  def change
    add_column :cards, :game_id, :bigint
  end
end
