require "json"
require 'pry-byebug'
require 'awesome_print'

filepath = "db/scrapping/hello_fresh_DB.json"

serialized_json = File.read(filepath)

json = JSON.parse(serialized_json)

ingr_all = json[0]["ingredients"]

ingr_all.each do |ingr|
  # ap ingr
  ingr.each { |e| ap e[1]["diet"] unless e[1]["diet"].empty? }
end
