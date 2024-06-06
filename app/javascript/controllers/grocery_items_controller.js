import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['bought'];
  static values = {
    id: Number,
  };
  connect() {}

  markAsBought(event) {

    console.log(this.idValue);
    const url = `../../grocery_items/${this.idValue}/mark_as_bought`;
    console.log(url);

    fetch(url, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'text/plain',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
      },
      body: 'test',
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);
        // this.boughtTarget.classList.toggle("my-icon-not-bought");
        // this.boughtTarget.classList.toggle("my-icon-bought");
      }
    )
  }
}
