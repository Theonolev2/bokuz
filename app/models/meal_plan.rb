class MealPlan < ApplicationRecord
  belongs_to :user
  has_many :meals, dependent: :destroy
  has_many :recipes, through: :meals
end
