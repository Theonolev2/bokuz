import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="overlay"
export default class extends Controller {
  static targets = ["overlay", "mealContent"];

  connect() {
    console.log("Overlay controller connected");
  }

  show(event) {
    event.preventDefault();
    this.overlayTarget.style.display = "flex";
    const mealId = event.currentTarget.dataset.mealId;
    console.log(mealId);

    fetch(`/meals/${mealId}`)
      .then(response => response.text())
      .then(html => {
        this.mealContentTarget.innerHTML = html;
        this.overlayTarget.style.display = "flex";
      });
  }

  hide() {
    console.log("hide");
    this.overlayTarget.style.display = "none";
  }
}
