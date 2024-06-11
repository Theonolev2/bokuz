class StoresController < ApplicationController
  def index
    @stores = Store.all
    # The `geocoded` scope filters only stores with coordinates
    @markers = @stores.geocoded.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude
      }
    end
  end
end
