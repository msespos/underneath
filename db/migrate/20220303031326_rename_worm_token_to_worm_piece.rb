class RenameWormTokenToWormPiece < ActiveRecord::Migration[6.1]
  def change
    rename_table :worm_tokens, :worm_pieces
  end
end
