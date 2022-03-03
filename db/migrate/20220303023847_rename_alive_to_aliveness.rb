class RenameAliveToAliveness < ActiveRecord::Migration[6.1]
  def change
    rename_column :human_tokens, :alive, :aliveness
  end
end
