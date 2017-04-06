class RenamePieceToWork < ActiveRecord::Migration[5.0]
  def change
    rename_table :pieces, :works
  end
end
