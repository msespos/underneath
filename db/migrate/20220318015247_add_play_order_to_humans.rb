class AddPlayOrderToHumans < ActiveRecord::Migration[6.1]
  def change
    add_column :humans, :play_order, :integer
  end
end
