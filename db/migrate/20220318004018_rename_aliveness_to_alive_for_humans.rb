class RenameAlivenessToAliveForHumans < ActiveRecord::Migration[6.1]
  def change
    rename_column :humans, :aliveness, :alive
  end
end
