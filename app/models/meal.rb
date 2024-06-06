class Meal < ApplicationRecord
  MAX_NB_PEOPLE = 12

  belongs_to :recipe
  belongs_to :meal_plan
  validates :nb_people, presence: true, inclusion: { in: 1..Meal::MAX_NB_PEOPLE }
end
