class DietTag < ApplicationRecord
  belongs_to :ingredient
  belongs_to :diet
  validates :diet, uniqueness: { scope: :ingredient }
end
