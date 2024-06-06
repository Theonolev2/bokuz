require 'nokogiri'
require 'open-uri'
require 'pry-byebug'
require 'awesome_print'
require "selenium-webdriver"
require 'json'

class GoogleImageScrapper
  def initialize(ingredient_names = [])
    @ingredient_names = ingredient_names
    @base_url = "https://www.google.com/search?tbm=isch&q="
  end

  def search
    @ingredient_names.each do |ingredient_name|
      puts "Searching for #{ingredient_name} images..."
      sleep rand(1..5) # Sleep for a random number of seconds to avoid being blocked by Google
      url = @base_url + URI::DEFAULT_PARSER.escape(ingredient_name)
      html = URI.open(url, 'User-Agent' => 'Mozilla/5.0').read
      doc = Nokogiri::HTML.parse(html)

      # Extract the first image URL
      first_image_url = doc.css('img').find { |img| img['src'] =~ /^http/ }['src']
      puts "First image URL for #{ingredient_name}: #{first_image_url}"
      return first_image_url
    rescue => e
      puts "An error occurred while searching for #{ingredient_name}: #{e.message}"
    end
  end
end


def fetch_recipes(url)
  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML.parse(html_file)
  recipe_grid = html_doc.search(".web-2imjyh").first
  recipe_links_elem = recipe_grid.search("a")
  recipes_fetched = []
  recipe_links_elem.map do |elem|
    recipe_json = fetch_recipe_description(elem["href"])
    recipes_fetched << recipe_json unless recipe_json.nil?
  end
  return recipes_fetched
end

def fetch_recipe_description(url)
  begin
    html_file = URI.open(url).read
    ap "URL => #{url}"
    rescue => exception
    return nil
  end
  html_doc = Nokogiri::HTML.parse(html_file)

  nb_people = 1 # html_doc.search(".mrtn-recette_ingredients-counter").first["data-servingsnb"].to_i

  photo_url_valid = ""
  if html_doc.search('div[data-test-id="recipe-hero-image"]').first.nil?
    photo_url_valid = "https://st3.depositphotos.com/4562487/13401/v/450/depositphotos_134013042-stock-illustration-hot-dish-on-plate-icon.jpg"
    puts "====== COULDN'T FIND A VALID URL FOR RECIPE PICTURE ========"
  else
    photo_url_valid = html_doc.search('div[data-test-id="recipe-hero-image"]').search("img").first["src"]
  end

  my_recipe = {
    title: html_doc.search(".gfOlWs").text.strip.gsub("\u0026 ", ""),
    description: html_doc.search(".FSngy li").text,
    photo_url: photo_url_valid,
    prep_time: html_doc.search(".hWQETT").first.text.strip,
    meal_url: url
  }

  ingredient_list = html_doc.search(".lbVUBR")
  my_ingredients = {}
  ingredient_list.map do |ingredient_card|
    # ap ingredient_card.search(".cJeggo").first
    ingr_diets = []
    if !ingredient_card.search(".cJeggo")[1].nil?
      ingr_diets = ingredient_card.search(".cJeggo")[1].search("b").text.strip.split(",").map!{ |e| e = e.strip }
    end

    ingr_val = ingredient_card.search(".cJeggo").text.strip.split

    if ingr_val[0].to_i.zero? && ["½", "selon", "¼", "⅓", "¾"].include?(ingr_val[0])
      weird_qty = { "½":0.5, "selon":-1, "¼":0.25, "⅓":0.33, "¾":0.75 }
      ingr_val[0] = weird_qty[ingr_val[0].to_sym]
    else
      ingr_val[0] = ingr_val[0].to_i
    end

    ingr_name = ingredient_card.search(".eERBYk").text.strip

    google_photo = GoogleImageScrapper.new([ingr_name]).search

    my_ingredients[ingr_name] = {
      qty_per_person: ingr_val[0],
      unit: ingr_val[1],
      photo_url: google_photo,
      diet: ingr_diets
    }
  end
  meal = {
    recipe: my_recipe,
    ingredients: my_ingredients
  }
  return meal
end

baseUrl = "https://www.hellofresh.fr/recipes/recettes-les-plus-populaires?"
recipes_fetched = fetch_recipes("#{baseUrl}")

puts "Storing #{recipes_fetched.size} meals"
File.open("db/scrapping/hello_fresh_DB.json", "w+") { |f| f.puts recipes_fetched.to_json }

# recipes_fetched = []
# 20.times do |idx|
#   recipes_fetched << fetch_recipes("#{baseUrl}#{startIdx + idx}")
# end
# recipes_fetched.flatten!
# puts "Storing #{recipes_fetched.size} meals"

# File.open("db/scrapping/meals_DB.json", "w+") { |f| f.puts recipes_fetched.to_json }
