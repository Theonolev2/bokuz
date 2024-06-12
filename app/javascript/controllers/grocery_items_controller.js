import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["item", "list"];

  connect() {
    console.log("connected");
    this.showTitles();
    }

  showTitles() {
    console.log("showTitles");
    const buyTitle = document.getElementById('buy-title');
    const boughtTitle = document.getElementById('bought-title');
    const listToBuy = document.querySelector('.to-buy');
    const listBought = document.querySelector('.bought');
    const noItems = document.getElementById('no-items');

    if (listToBuy.children.length === 0) {
      console.log("all items are bought");
      noItems.style.display = "flex";
      listToBuy.style.display = "none";
      } else {
      noItems.style.display = "none";
      buyTitle.style.display = "flex";
      listToBuy.style.display = "flex";
    }

    if (listBought.children.length === 0) {
      console.log("no items bought");
      boughtTitle.style.display = "none";
      listBought.style.display = "none";
    } else {
      boughtTitle.style.display = "flex";
      listBought.style.display = "flex";
      console.log("items bought");
    }

  }

  markAsBought(event) {
    const buyTitle = document.getElementById('buy-title');
    const boughtTitle = document.getElementById('bought-title');
    const target = event.currentTarget;
    const parentTarget = target.parentElement;
    const listToBuy = document.querySelector('.to-buy');
    const listBought = document.querySelector('.bought');

    // target.classList.add('fadeOut');
    if (parentTarget.classList.contains('to-buy')) {
      console.log("target parent is to-buy");
      // console.log("listToBuy", listToBuy);
      // setTimeout(() => {

      // }, 1000);
      // target.classList.remove('fadeOut');
      listToBuy.removeChild(target);
      listBought.insertAdjacentElement('afterbegin', target);
      console.log("passe par ici");

    } else if (parentTarget.classList.contains('bought')) {
      console.log("target parent is bought");
      // setTimeout(() => {

        // }, 1000);
      listBought.removeChild(target);
      listToBuy.insertAdjacentElement('afterbegin', target);
      console.log("passe par ici");
    }

    // target.classList.remove('fadeOut');
    this.showTitles();


    console.log("listToBuy.children.length", listToBuy.children.length);

    const url = `/grocery_items/${target.dataset.id}/mark_as_bought`;
    console.log(url);
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
            }
          )
  }
}
