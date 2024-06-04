class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :meal_plans, dependent: :destroy
  has_many :meals, through: :meal_plans, dependent: :destroy
  has_many :grocery_items, through: :meal_plans, dependent: :destroy
  has_many :user_diets, dependent: :destroy
  has_many :diets, through: :user_diets
end
