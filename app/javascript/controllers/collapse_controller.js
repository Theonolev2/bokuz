import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="collapse"
export default class extends Controller {
  static targets = [ "block", "button" ]

  connect() {
    console.log("Connected to collapse controller")
  }

  open(event) {
    this.blockTargets.forEach((block) => {
      block.classList.toggle("show")
    })
    this.buttonTargets.forEach((button) => {
      button.disabled = !button.disabled
    })
  }
}
