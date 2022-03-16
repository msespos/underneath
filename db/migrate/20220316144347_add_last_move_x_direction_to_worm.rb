class AddLastMoveXDirectionToWorm < ActiveRecord::Migration[6.1]
  def change
    add_column :worms, :last_move_x_direction, :integer
  end
end
