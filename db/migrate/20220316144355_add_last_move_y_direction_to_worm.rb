class AddLastMoveYDirectionToWorm < ActiveRecord::Migration[6.1]
  def change
    add_column :worms, :last_move_y_direction, :integer
  end
end
