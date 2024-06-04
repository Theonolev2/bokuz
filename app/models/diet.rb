class Diet < ApplicationRecord
  DIET_TYPE = %i[not_vegetarian not_vegan lactose gluten pork glucose nuts sea_food]
  has_many :diet_tags
  has_many :ingredients, through: :diet_tags
  has_many :user_diets
  has_many :users, through: :user_diets
  validates :name, presence: true, uniqueness: true
end
