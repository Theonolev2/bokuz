import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="removals"
export default class extends Controller {
  connect() {
    console.log("connect");

  }

  remove() {
    console.log("remove");
    this.element.remove()
  }
}
