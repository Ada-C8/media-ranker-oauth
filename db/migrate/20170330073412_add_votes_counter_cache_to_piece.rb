class AddVotesCounterCacheToPiece < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :votes_count, :integer, default: 0
  end
end
