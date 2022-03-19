class AddFaceUpToCards < ActiveRecord::Migration[6.1]
  def change
    add_column :cards, :face_up, :boolean
  end
end
