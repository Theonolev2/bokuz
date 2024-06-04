class Recipe < ApplicationRecord
  has_many :recipe_ingredients, dependent: :destroy
  has_many :meals
  has_many :ingredients, through: :recipe_ingredients
  has_many :diet_tags, through: :ingredients
  has_many :diets, through: :diet_tags
  validates :title, :description, :prep_time, presence: true
end
