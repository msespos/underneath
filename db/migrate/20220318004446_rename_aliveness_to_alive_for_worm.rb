class RenameAlivenessToAliveForWorm < ActiveRecord::Migration[6.1]
  def change
    rename_column :worms, :aliveness, :alive
  end
end
