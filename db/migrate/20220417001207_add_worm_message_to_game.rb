class AddWormMessageToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :worm_message, :string
  end
end
