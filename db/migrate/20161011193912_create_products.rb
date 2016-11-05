class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.string :category
      t.string :brand
      t.integer :size
      t.integer :discount
      t.string :color
      t.boolean :availability

      t.timestamps null: false
    end
  end
end
