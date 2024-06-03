class DietTag < ApplicationRecord
  belongs_to :ingredient
  belongs_to :diet
end
