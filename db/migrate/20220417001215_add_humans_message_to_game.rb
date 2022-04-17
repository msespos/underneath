class AddHumansMessageToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :humans_message, :string
  end
end
