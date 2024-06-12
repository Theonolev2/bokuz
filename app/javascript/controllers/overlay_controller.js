import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="overlay"
export default class extends Controller {
  static targets = ["overlay", "mealContent"];

  connect() {
    console.log("Overlay controller connected");
  }

  prevent(event) {
    event.stopPropagation();
  }

  show(event) {
    console.log("show");
    event.preventDefault();
    const mealId = event.currentTarget.dataset.mealId;

    fetch(`/meals/${mealId}`, {
      headers: {
        Accept: "text/plain",
        "X-CSRF-Token": document.head.querySelector("meta[name=csrf-token]")
          .content,
      },
    })
      .then((response) => response.text())
      .then((html) => {
        this.mealContentTarget.innerHTML = html;
        this.overlayTarget.classList.add("active");
      });
  }

  hide() {
    this.overlayTarget.classList.add("hide");
    setTimeout(() => {
      this.overlayTarget.classList.remove("active");
      this.overlayTarget.classList.remove("hide");
    }, 300);
  }
}
