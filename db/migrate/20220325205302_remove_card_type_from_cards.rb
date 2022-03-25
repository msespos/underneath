class RemoveCardTypeFromCards < ActiveRecord::Migration[6.1]
  def change
    remove_column :cards, :card_type, :string
  end
end
