class PubDateToPubYear < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :publication_date
    add_column :pieces, :publication_year, :integer
  end
end
