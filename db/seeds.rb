# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

MealPlan.destroy_all
Meal.destroy_all
Recipe.destroy_all
Ingredient.destroy_all
Diet.destroy_all

puts "creating diets..."
Diet::DIET_TYPE.each do |diet_type|
  Diet.create!(name: diet_type.to_s)
end
puts "diets creation done\n\n"

puts "creating ingredients..."
10.times do
  ingredient = Ingredient.new!(name: Faker::Food.ingredient)
  ingredient.diets << Diet.find_by(name: Diet::DIET_TYPE.sample.to_s)
end
puts "ingredients creation done\n\n"
