class CreateDietTags < ActiveRecord::Migration[7.1]
  def change
    create_table :diet_tags do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :diet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
