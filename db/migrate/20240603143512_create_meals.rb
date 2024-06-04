class CreateMeals < ActiveRecord::Migration[7.1]
  def change
    create_table :meals do |t|
      t.integer :nb_people
      t.references :recipe, null: false, foreign_key: true
      t.references :meal_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
