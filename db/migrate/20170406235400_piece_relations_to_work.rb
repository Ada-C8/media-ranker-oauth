class PieceRelationsToWork < ActiveRecord::Migration[5.0]
  def change
    rename_column :votes, :piece_id, :work_id
  end
end
