class MealPlan < ApplicationRecord
  belongs_to :user, optional: true
  has_many :meals, dependent: :destroy
  has_many :recipes, through: :meals
  has_many :grocery_items, dependent: :destroy
  has_many :ingredients, through: :grocery_items
end
