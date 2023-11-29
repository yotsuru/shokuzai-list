class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.references :genre, null: false,foreign_key: true
      t.references :user, null: false,foreign_key: true
      t.string :name, null: false
      t.date :expiration_date
      t.date :purchase_date
      t.float :quantity, null: false
      t.string :unit
      t.timestamps
    end
  end
end
