class AddGameIdToWormPieces < ActiveRecord::Migration[6.1]
  def change
    add_column :worm_pieces, :game_id, :bigint
  end
end
