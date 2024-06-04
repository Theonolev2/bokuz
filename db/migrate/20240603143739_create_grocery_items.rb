class CreateGroceryItems < ActiveRecord::Migration[7.1]
  def change
    create_table :grocery_items do |t|
      t.float :qty_to_buy
      t.boolean :bought
      t.references :ingredient, null: false, foreign_key: true
      t.references :meal_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
