class AddEmergentToWorm < ActiveRecord::Migration[6.1]
  def change
    add_column :worms, :emergent, :boolean
  end
end
