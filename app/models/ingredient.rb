class Ingredient < ApplicationRecord
  has_many :diet_tags, dependent: :destroy
  has_many :diets, through: :diet_tags
  validates :name, presence: true, uniqueness: true
end
