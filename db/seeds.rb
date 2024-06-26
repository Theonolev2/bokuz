require 'faker'

require "json"
require 'pry-byebug'
require 'awesome_print'

filepath = "db/scrapping/hello_fresh_DB.json"

serialized_json = File.read(filepath)

json = JSON.parse(serialized_json)

puts "DB cleaning..."
MealPlan.destroy_all
Meal.destroy_all
Recipe.destroy_all
Ingredient.destroy_all
User.destroy_all
Diet.destroy_all
puts "DB cleaning done"

puts "creating user..."
User.create!(email: "test@test.com", password: "111111")
User.create!(email: "tocard@example.com", password: "111111")
puts "user creation done\n\n"

puts "creating diets..."
Diet::DIET_TYPE.each do |diet_type|
  Diet.create!(name: diet_type.to_s)
  # case when in Ruby to add a label to each diet_type
  case diet_type
  when :not_vegetarian
    Diet.last.update!(label: "Végétarien")
  when :not_vegan
    Diet.last.update!(label: "Vegan")
  when :lactose
    Diet.last.update!(label: "Sans lactose")
  when :gluten
    Diet.last.update!(label: "Sans gluten")
  when :pork
    Diet.last.update!(label: "Sans porc")
  when :glucose
    Diet.last.update!(label: "Sans glucose")
  when :nuts
    Diet.last.update!(label: "Sans fruits à coque")
  when :sea_food
    Diet.last.update!(label: "Sans produits de la mer")
  end
end
User.all.each { |user| user.diets << Diet.all.sample }
puts "diets creation done\n\n"

puts "populating ingredients..."
json.each do |elem|
  elem["ingredients"].each do |ingredient|
    if Ingredient.find_by(name: ingredient.first).nil?
      Ingredient.create!(name: ingredient.first, photo_url: ingredient[1]["photo_url"], unit: ingredient[1]["unit"])
      ingredient[1]["diet"].each do |diet|
        diet_obj = Diet.find_by(name: diet)
        ingredient_obj = Ingredient.find_by(name: ingredient.first)
        ingredient_obj.diets << diet_obj
      end
    end
  end
end
puts "ingredients populating done\n\n"

puts "populating recipes..."
json.each do |elem|
  json_recipe = elem["recipe"]
  # ap json_recipe
  recipe_obj = Recipe.create!(
    title: json_recipe["title"],
    description: json_recipe["description"],
    photo_url: json_recipe["photo_url"],
    prep_time: json_recipe["prep_time"],
    meal_url: json_recipe["meal_url"]
  )
  json_ingredients = elem["ingredients"]
  json_ingredients.each do |ingredient|
    ingredient_obj = Ingredient.find_by(name: ingredient[0])
    recipe_ingredient_join = RecipeIngredient.create!(ingredient: ingredient_obj, recipe: recipe_obj, qty_per_person: ingredient[1]["qty_per_person"])
  end
end
puts "recipes populating done\n\n"

puts "creating meal plans..."
# meal_plan_names = %w[portion sour leaf oven appoint free trip tasty cash desert knot parade miscarriage building eyebrow]
10.times do
  meal_plan = MealPlan.new
  meal_plan.user = User.first
  # meal_plan.name = meal_plan_names.sample
  2.times do
    meal_plan.recipes << Recipe.all.sample
  end
  meal_plan.recipes.each do |recipe|
    recipe.ingredients.each do |ingredient|
      grocery_item = GroceryItem.new(ingredient: ingredient, bought: false, qty_to_buy: 1)
      meal_plan.grocery_items << grocery_item
    end
  end
  meal_plan.meals.each { |meal| meal.nb_people = 4 }
  meal_plan.save!
end
puts "meal plans creation done\n\n"

puts "Creating stores..."
Store.create!(name: "Carrefour city", address: "1 Pl. Croix-Paquet, 69001 Lyon")
Store.create!(name: "Petit Casino", address: "31 Rue des Capucins, 69001 Lyon")
Store.create!(name: "Auchan Piéton", address: "43 Rue René Leynaud, 69001 Lyon")
Store.create!(name: "Carrefour Express", address: "10 Rue Paul Chenavard, 69001 Lyon")
Store.create!(name: "Les Halles de Pouteau", address: "23 Rue Pouteau, 69001 Lyon")
Store.create!(name: "Casino Shop", address: "6 Pl. Sathonay, 69001 Lyon")
Store.create!(name: "Vival", address: "1 Rue du Bon-Pasteur, 69001 Lyon")
puts "Stores creation done\n\n"
