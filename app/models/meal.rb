class Meal < ApplicationRecord
  belongs_to :recipe
  belongs_to :meal_plan
  validates :nb_people, presence: true, inclusion: { in: 1..12 }
end
