class AddLastRevealedCardMessageToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :last_revealed_card_message, :string
  end
end
