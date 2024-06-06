class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  validates :qty_per_person, presence: true
end
