require "capybara/rspec"
require "awesome_print"
require "active_support/all"
require "spec_helper"

ap "before Rspec"
RSpec.describe "Site Scraper", type: :feature do
  ap "within Rspec"
  it "scrape le contenu après le chargement JavaScript" do
    ap "within it"
    visit "https://www.marmiton.org/recettes/recette_blanquette-de-veau-facile_19219.aspx"

    pic_thumbnail = find("#recipe-media-viewer-thumbnail-0")
    ap pic_thumbnail
    # pic_thumbnail.click
    # sleep 1

    # photo_url = find(".af_diapo_zoom")
  end
end
