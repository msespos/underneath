class AddTurnToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :turn, :int
  end
end
