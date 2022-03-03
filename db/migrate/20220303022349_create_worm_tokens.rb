class CreateWormTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :worm_tokens do |t|
      t.boolean :aliveness
      t.integer :x_position
      t.integer :y_position

      t.timestamps
    end
  end
end
