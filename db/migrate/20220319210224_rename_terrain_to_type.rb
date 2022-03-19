class RenameTerrainToType < ActiveRecord::Migration[6.1]
  def change
    rename_column :cards, :terrain, :type
  end
end
