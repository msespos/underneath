class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.integer :x_position
      t.integer :y_position
      t.string :terrain
      t.string :face_up_or_down
      t.boolean :has_bomb

      t.timestamps
    end
  end
end
