require 'nokogiri'
require 'open-uri'
require 'pry-byebug'
require 'awesome_print'
require 'json'

def fetch_recipes(url)
  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML.parse(html_file)

  recipes_fetched = []
  html_doc.search(".recipe-card").each do |recipe_card|
    if recipe_card.search(".recipe-card__youtube-video-play").empty?
      recipes_fetched << fetch_recipe_description(recipe_card.search(".recipe-card-link").first["href"])
    end
  end
  return recipes_fetched
end

def fetch_recipe_description(url)
  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML.parse(html_file)

  nice_description = html_doc.search(".recipe-step-list").text.strip.gsub(/\s{2,}/, "").gsub("\n", "")

  # Adding new line before and after "Etape #"
  etapes = nice_description.scan(/Étape \d+/)
  etapes.each_with_index do |etape, idx|
    nice_description.insert(nice_description.index(etape), "\n") unless idx == 0
    nice_description.insert(nice_description.index(etape) + etape.size, "\n")
  end

  nb_people = html_doc.search(".mrtn-recette_ingredients-counter").first["data-servingsnb"].to_i

  photo_url_valid = ""
  if html_doc.search(".recipe-media-viewer-picture").first.nil?
    photo_url_valid = "https://st3.depositphotos.com/4562487/13401/v/450/depositphotos_134013042-stock-illustration-hot-dish-on-plate-icon.jpg"
  else
    photo_url_valid = html_doc.search(".recipe-media-viewer-picture").first["data-src"]
  end

  my_recipe = {
    title: html_doc.search(".main-title").search("h1").text.strip,
    description: nice_description,
    photo_url: photo_url_valid,
    prep_time: html_doc.search(".recipe-primary__item").search("span").first.text.strip,
    meal_url: url
  }

  ingredient_list = html_doc.search(".mrtn-recette_ingredients-items").search(".card-ingredient")
  my_ingredients = {}
  ingredient_list.map do |ingredient_card|
    my_ingredients[ingredient_card["data-name"]] = {
      qty_per_person: ingredient_card.search(".card-ingredient-quantity").first["data-ingredientquantity"].to_i.fdiv(nb_people).round(1),
      unit: ingredient_card.search(".unit").first["data-unitsingular"],
      photo_url: ingredient_card.search(".item__icon").first["data-src"]
    }
  end
  meal = {
    recipe: my_recipe,
    ingredients: my_ingredients
  }
  return meal
end

baseUrl = "https://www.marmiton.org/recettes/index/categorie/plat-principal/"
startIdx = 0

recipes_fetched = []
20.times do |idx|
  recipes_fetched << fetch_recipes("#{baseUrl}#{startIdx + idx}")
end
recipes_fetched.flatten!
puts "Storing #{recipes_fetched.size} meals"

File.open("db/scrapping/marmiton_DB.json", "w+") { |f| f.puts recipes_fetched.to_json }
