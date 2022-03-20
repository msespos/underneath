class AddHumansBombsToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :humans_bombs, :integer
  end
end
