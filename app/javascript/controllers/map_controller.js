import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl"; // Don't forget this!

export default class extends Controller {
  // create an array to store the markers created in the function addMarkersToMap

  static values = {
    apiKey: String,
    markers: Array,
   };

  connect() {
    this.markers = [];
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      });
      this.#addUsersToMap();
      this.#addMarkersToMap();
      this.#fitMapToMarkers()
  }

  #addUsersToMap() {
    const el = document.createElement('div');
    el.className = 'marker';

    navigator.geolocation.getCurrentPosition((position) => {
      const popup = new mapboxgl.Popup().setHTML("<h1>Toi<h1>");
      this.markers.push(new mapboxgl.Marker(el)
        .setLngLat([position.coords.longitude, position.coords.latitude])
        .setPopup(popup)
        .addTo(this.map));
    });
  }

  #addMarkersToMap() {
    this.markersValue.forEach(marker => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html);
      this.markers.push(new mapboxgl.Marker({ "color": "#b40219", "size": "small" })
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map));
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markers.forEach(marker =>
      bounds.extend([marker.getLngLat().lng, marker.getLngLat().lat])
    );
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }
}
