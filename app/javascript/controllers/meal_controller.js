import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meal"
export default class extends Controller {
  connect() {
  }

  // Connects to data-action="click->meal#delete"
  delete(event) {
    event.preventDefault();
    // fetch the destroy method of the meal controller
    fetch(`/meals/${this.data.get("id")}`, {
      method: "DELETE",
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-Token": document.head.querySelector("meta[name=csrf-token]")?.content
      }
    }).then(this.element.remove()).catch((error) => console.error("Error:", error));
  }

  replace(event) {
    event.preventDefault();
    // fetch the destroy method of the meal controller
    fetch(`/meals/${this.data.get("id")}/replace`, {
      method: "PATCH",
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-Token": document.head.querySelector("meta[name=csrf-token]")?.content
      }
    }).catch((error) => console.error("Error:", error));
  }
}
