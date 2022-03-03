class RenameHumanTokenToHuman < ActiveRecord::Migration[6.1]
  def change
    rename_table :human_tokens, :humans
  end
end
