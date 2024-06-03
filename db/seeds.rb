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

p "DB cleaning..."
MealPlan.destroy_all
Meal.destroy_all
Recipe.destroy_all
Ingredient.destroy_all
User.destroy_all
Diet.destroy_all
p "DB cleaning done"

puts "creating user..."
User.create!(email: "test@test.com", password: "111111")
puts "user creation done\n\n"


puts "creating diets..."
Diet::DIET_TYPE.each do |diet_type|
  Diet.create!(name: diet_type.to_s)
end
User.all.each { |user| user.diets << Diet.all.sample }
puts "diets creation done\n\n"

puts "creating ingredients..."
10.times do
  ingredient = Ingredient.new(name: Faker::Food.ingredient)
  ingredient.diets << Diet.find_by(name: Diet::DIET_TYPE.sample.to_s)
  ingredient.save!
end
puts "ingredients creation done\n\n"

puts "creating recipes"
10.times do
  recipe = Recipe.new(title: Faker::Food.dish, description: Faker::Food.description, prep_time: 10)
  recipe.ingredients << Ingredient.all.sample(2)
  recipe.recipe_ingredients.each do |elem|
    elem.qty_per_person = 1
    elem.unit = "g"
  end
  recipe.save!
end
puts "recipe creation done\n\n"

puts "creating meal plans"
10.times do
  meal_plan = MealPlan.new
  meal_plan.user = User.first
  2.times do
    meal_plan.recipes << Recipe.all.sample
  end
  meal_plan.recipes.each do |recipe|
    recipe.ingredients.each do |ingredient|
      grocery_item = GroceryItem.new(ingredient: ingredient, bought: false, qty_to_buy: 1)
      meal_plan.grocery_items << grocery_item
    end
  end
  meal_plan.meals.each { |meal| meal.nb_people = 1 }
  meal_plan.save!
end
puts "meal plans creation done\n\n"
