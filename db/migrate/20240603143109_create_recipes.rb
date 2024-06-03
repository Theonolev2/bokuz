class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.string :photo_url
      t.integer :prep_time
      t.string :meal_url

      t.timestamps
    end
  end
end
