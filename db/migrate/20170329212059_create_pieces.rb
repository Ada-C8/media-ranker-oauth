class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.string :title
      t.string :creator
      t.string :description
      t.date :publication_date
      t.string :category

      t.timestamps
    end
  end
end
