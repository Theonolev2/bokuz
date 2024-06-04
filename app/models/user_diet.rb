class UserDiet < ApplicationRecord
  belongs_to :user
  belongs_to :diet
  validates :diet, uniqueness: { scope: :user }
end
