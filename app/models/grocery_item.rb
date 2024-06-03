class GroceryItem < ApplicationRecord
  belongs_to :ingredient
  belongs_to :meal_plan
  validates :qty_to_buy, :bought, presence: true
end
