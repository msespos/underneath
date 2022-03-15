class RemoveNumberOfBombosFromHumans < ActiveRecord::Migration[6.1]
  def change
    remove_column :humans, :number_of_bombs
  end
end
