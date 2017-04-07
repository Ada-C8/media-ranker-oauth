class AddForeignKeyConstraints < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :votes, :users
    add_foreign_key :votes, :works
  end
end
