class CreateActiveBombs < ActiveRecord::Migration[6.1]
  def change
    create_table :active_bombs do |t|
      t.integer :x_position
      t.integer :y_position

      t.timestamps
    end
  end
end
