class GroceryItem < ApplicationRecord
  belongs_to :ingredient
  belongs_to :meal_plan
  validates :qty_to_buy, presence: true
  validates :bought, inclusion: { in: [true, false] }
end
