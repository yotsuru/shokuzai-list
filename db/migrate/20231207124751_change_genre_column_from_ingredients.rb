class ChangeGenreColumnFromIngredients < ActiveRecord::Migration[6.1]
  def up
    # remove_foreign_key :ingredients, :genre_id
    remove_index :ingredients, :genre_id
    change_column :ingredients, :genre_id, :integer, null: true
  end
  
  def down
    # remove_foreign_key :ingredients, :genre_id
    add_index :ingredients, :genre_id
    change_column :ingredients, :genre_id, :integer, null: false
  end
end
