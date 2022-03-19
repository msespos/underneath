class RemoveFaceUpOrDownFromCards < ActiveRecord::Migration[6.1]
  def change
    remove_column :cards, :face_up_or_down, :string
  end
end
