import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="change-qty"
export default class extends Controller {
  static targets = ["nbInput", "nbQty", "form"];
  static values = { max: Number };

  connect() {
    // console.log("Connected to change qty controller");
  }

  increase() {
    const valueToIncrease = parseInt(this.nbQtyTarget.innerText);
    if (valueToIncrease < this.maxValue) {
      this.nbQtyTarget.innerText = valueToIncrease + 1;

      if (this.hasNbInputTarget) {
        this.nbInputTarget.value = valueToIncrease + 1;
      }

      if (this.hasFormTarget) {
        this.fetchSubmit(this.formTarget);
      }
    }
  }

  decrease() {
    const valueToDecrease = parseInt(this.nbQtyTarget.innerText);
    if (valueToDecrease > 1) {
      this.nbQtyTarget.innerText = valueToDecrease - 1;

      if (this.hasNbInputTarget) {
        this.nbInputTarget.value = valueToDecrease - 1;
      }

      if (this.hasFormTarget) {
        this.fetchSubmit(this.formTarget);
      }
    }
  }

  fetchSubmit(formTarget) {
    fetch(formTarget.action, {
      method: formTarget.method,
      accept: "application/json",
      body: new FormData(formTarget),
    })
      .then(response => response.json())
      .then(data => {
        console.log("Success:", data);
      });
  }
}
