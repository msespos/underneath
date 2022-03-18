class AddPhaseToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :phase, :string
  end
end
