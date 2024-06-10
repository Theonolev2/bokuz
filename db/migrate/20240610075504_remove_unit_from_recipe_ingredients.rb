class RemoveUnitFromRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipe_ingredients, :unit, :string
  end
end
