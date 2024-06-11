import { Controller } from "@hotwired/stimulus";
// import Hammer from 'hammerjs';
import Swiper from 'swiper';

export default class extends Controller {

  connect() {
    console.log("connected");
  }

  selectOption(event) {
    console.log("test");
    // Handle the swipe action here
    const direction = event.type === 'swipeleft' ? 'left' : 'right';
    console.log(`Swiped ${direction}`);
    // Implement your logic (e.g., show/hide menu options, navigate, etc.)
  }
}
