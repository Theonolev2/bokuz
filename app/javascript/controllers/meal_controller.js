import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="meal"
export default class extends Controller {
  connect() {}

  showDeleteModal(event) {
    event.preventDefault();

    // Show the modal
    let modal = document.getElementById("deleteModal");
    let deleteBtn = document.getElementById("deleteBtn");
    modal.style.display = "block";
    modal.classList.add("show");

    deleteBtn.dataset.mealIdInfo = event.currentTarget.dataset.mealId;
  }

  dismiss(event) {
    console.log("dismiss");
    let modal = document.getElementById("deleteModal");
    modal.style.display = "none";
    modal.classList.remove("show");
  }

  // Connects to data-action="click->meal#delete"
  delete(event) {
    event.preventDefault();

    const meal = document.querySelector(
      `[data-meal-id="${event.currentTarget.dataset.mealIdInfo}"]`
    );

    // fetch the destroy method of the meal controller
    fetch(`/meals/${event.currentTarget.dataset.mealIdInfo}`, {
      method: "DELETE",
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-Token": document.head.querySelector("meta[name=csrf-token]")
          ?.content,
      },
    })
      .then(meal.remove())
      .catch(error => console.error("Error:", error));

    this.dismiss();
  }

  // action not yet implemented in the meal controller of the meal_plans_show view (using turbo instead)
  replace(event) {
    event.preventDefault();
    // fetch the destroy method of the meal controller
    fetch(`/meals/${this.data.get("id")}/replace`, {
      method: "PATCH",
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-Token": document.head.querySelector("meta[name=csrf-token]")
          ?.content,
      },
    }).catch(error => console.error("Error:", error));
  }
}
