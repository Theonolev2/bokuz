import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static values = {
    id: Number,
  };
  connect() {}

  markAsBought(event) {

    const target = event.currentTarget;
    const url = `/grocery_items/${target.dataset.id}/mark_as_bought`;

    fetch(url, {
      method: 'PATCH',
      headers: {
        'Accept': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
      },
      body: {},
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(target);
        target.outerHTML = data.partial;
        location.reload();
      }
    )
  }
}
