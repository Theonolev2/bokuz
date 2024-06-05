require "json"
require 'awesome_print'

filepath = "db/scrapping/meals_test.json"

serialized_json = File.read(filepath)

json = JSON.parse(serialized_json)

json.each_with_index do |meal, id|
  descr = meal["recipe"]["description"]

  etapes = descr.scan(/Étape \d+/)

  etapes.each_with_index do |etape, idx|
    descr.insert(descr.index(etape), "\n") unless idx == 0
    descr.insert(descr.index(etape)+etape.size, "\n")
  end

  json[id]["recipe"]["description"] = descr
end

ap json[0]

File.open("db/scrapping/meals_test.json", "w") { |f| f.puts json.to_json }
