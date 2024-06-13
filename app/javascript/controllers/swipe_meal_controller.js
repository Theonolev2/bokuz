import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  connect() {
    console.log("connected");
  }
}

let touchstartX = 0;
let touchcurrentX = 0;
let touchendX = 0;
let baseWidth = 0;
let isDragging = false;

const gesturedZones = document.querySelectorAll('.card-meal');


const maxWidth = gesturedZones[0].offsetWidth;
const minWidth = Math. floor(maxWidth * 0.8); // 80% of the max width


gesturedZones.forEach(function(gesturedZone) {
  const iconZone = gesturedZone.nextElementSibling;
  gesturedZone.addEventListener('touchstart', function(event) {
    isDragging = true;
    touchstartX = event.changedTouches[0].screenX;
    baseWidth = gesturedZone.offsetWidth;
  }, { passive: true });

  gesturedZone.addEventListener('touchmove', function(event) {
    if (!isDragging) return;
    touchcurrentX = event.changedTouches[0].screenX;
    const translateX = touchcurrentX - touchstartX;
    // let cardWidth = 0;
    // if (translateX < 0) {
    //   cardWidth = Math.max(minWidth, (maxWidth + translateX));
    // } else {
    //   cardWidth = Math.min(maxWidth, (minWidth + translateX));
    // }
    console.log(translateX);
    gesturedZone.style.transform = `translateX(${translateX}px)`;
    iconZone.setAttribute("style",`width: ${Math.floor(Math.abs(translateX-10))}px`);
    // gesturedZone.setAttribute("style",`transform: translateX(-${translateX}px)`);
  }, { passive: true });

  gesturedZone.addEventListener('touchend', function(event) {
    if (!isDragging) return;
    isDragging = false;
    touchendX = event.changedTouches[0].screenX;
    gesturedZone.animate([
      { transform: `translateX(-${150}px)` }
    ], {
      duration: 500,
      iterations: 1,
      fill: "forwards",
      easing: "ease-in-out"
    });
    iconZone.animate([
      { width: `${160}px` }
    ], {
      duration: 500,
      iterations: 1,
      fill: "forwards",
      easing: "ease-in-out"
    });
    handleGesure();
  }, false);
});

function handleGesure() {
    let swiped = 'swiped: ';
    if (touchendX < touchstartX) {
        // alert(swiped + 'left!');
    }
    if (touchendX > touchstartX) {
        // alert(swiped + 'right!');
    }
}
