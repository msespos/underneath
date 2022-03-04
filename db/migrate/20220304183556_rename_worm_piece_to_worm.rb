class RenameWormPieceToWorm < ActiveRecord::Migration[6.1]
  def change
    rename_table :worm_pieces, :worms
  end
end
