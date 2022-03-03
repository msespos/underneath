class CreateHumanTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :human_tokens do |t|
      t.boolean :alive
      t.integer :x_position
      t.integer :y_position
      t.integer :number_of_bombs

      t.timestamps
    end
  end
end
