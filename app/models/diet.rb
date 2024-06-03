class Diet < ApplicationRecord
  DIET_TYPE = %i[vegetarian vegan lactose_free gluten_free pork_free glucose_free nuts_free sea_food_free]
  validates :name, presence: true
end
