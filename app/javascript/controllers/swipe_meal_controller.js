import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  connect() {
    console.log("connected");
  }
}

let touchstartX = 0;
let touchcurrentX = 0;
let touchendX = 0;
let isDragging = false;

let gesturedZones = document.querySelectorAll('.gestured-zone');

gesturedZones.forEach(function(gesturedZone) {
  gesturedZone.addEventListener('touchstart', function(event) {
    isDragging = true;
    touchstartX = event.changedTouches[0].screenX;
  }, { passive: true });

  gesturedZone.addEventListener('touchmove', function(event) {
    if (!isDragging) return;
    touchcurrentX = event.changedTouches[0].screenX;
    const translateX = Math.min(0, touchcurrentX - touchstartX);
    console.log(gesturedZone.style);
    const cardWidth = gesturedZone.style.width + translateX;
    gesturedZone.style.width = `${cardWidth}px`;
  }, { passive: true });

  gesturedZone.addEventListener('touchend', function(event) {
    if (!isDragging) return;
    isDragging = false;
    touchendX = event.changedTouches[0].screenX;
    handleGesure();
  }, false);
});

function handleGesure() {
    let swiped = 'swiped: ';
    if (touchendX < touchstartX) {
        alert(swiped + 'left!');
    }
    if (touchendX > touchstartX) {
        alert(swiped + 'right!');
    }
}
