class AddVotesCounterCacheToPiece < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :vote_count, :integer, default: 0
  end
end
