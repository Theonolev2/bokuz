import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['bought']
  connect() {

    // mark_as_bought() {

    //   if (this.boughtTarget.classList.contains("my-icon-bought")) {
    //     this.boughtTarget.classList.remove("my-icon-bought")
    //     this.boughtTarget.classList.add("my-icon-not-bought")
    //   }
    //   else {
    //     this.boughtTarget.classList.remove("my-icon-not-bought")
    //     this.boughtTarget.classList.add("my-icon-bought")
    //   };
    // }
    console.log("grocery-items controller connected")

  }
}
