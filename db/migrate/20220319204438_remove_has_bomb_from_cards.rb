class RemoveHasBombFromCards < ActiveRecord::Migration[6.1]
  def change
    remove_column :cards, :has_bomb, :boolean
  end
end
