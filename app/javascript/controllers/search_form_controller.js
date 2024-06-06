import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search-form"
export default class extends Controller {
  static targets = ["nbInput", "nbQty"];
  static values = { max: Number };

  connect() {
    console.log("Connected to search form controller");
  }

  increase() {
    const valueToIncrease = parseInt(this.nbQtyTarget.innerText);
    if (valueToIncrease < this.maxValue) {
      this.nbQtyTarget.innerText = valueToIncrease + 1;
      this.nbInputTarget.value = valueToIncrease + 1;
    }
  }

  decrease() {
    const valueToDecrease = parseInt(this.nbQtyTarget.innerText);
    if (valueToDecrease > 1) {
      this.nbQtyTarget.innerText = valueToDecrease - 1;
      this.nbInputTarget.value = valueToDecrease - 1;
    }
  }
}
