class RenameTypeToCardType < ActiveRecord::Migration[6.1]
  def change
    rename_column :cards, :type, :card_type
  end
end
