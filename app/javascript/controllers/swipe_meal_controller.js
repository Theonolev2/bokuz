import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  connect() {
    console.log("connected");

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
    console.log(iconZone);
    // iconZone.setAttribute("style", "visibility: visible;");
    touchstartX = event.changedTouches[0].screenX;
    baseWidth = gesturedZone.offsetWidth;
    }, { passive: true });

    gesturedZone.addEventListener('touchmove', function(event) {
      touchcurrentX = event.changedTouches[0].screenX;
      const translateX = touchcurrentX - touchstartX;
      if (Math.abs(translateX) > 25) {
      isDragging = true;
      gesturedZone.style.transform = `translateX(${translateX}px)`;
      iconZone.setAttribute("style",`width: ${Math.floor(Math.abs(translateX-10))}px; visibility: visible;`);
    } else {
      if (isDragging == true) {
        gesturedZone.style.transform = `translateX(${translateX}px)`;
        iconZone.setAttribute("style",`width: ${Math.floor(Math.abs(translateX-10))}px; visibility: visible;`);
      }
    }
  }, { passive: true });

  gesturedZone.addEventListener('touchend', async function(event) {
    // if (!isDragging) return;
    isDragging = false;
    touchendX = event.changedTouches[0].screenX;
    if (Math.abs(touchendX - touchstartX) < 150){
      // ON REFERME LE TRUC
      let tempo = gesturedZone.style.transform.match(/\d+/)[0];
      while(tempo != 0) {
        if (tempo > 0 ) {
          tempo--;
          iconZone.style.width = `${tempo}px`;
          gesturedZone.style.transform = `translateX(-${tempo}px)`;
        } else {
          tempo++;
          gesturedZone.style.transform = `translateX(${tempo}px)`;
        }
        await new Promise(resolve => setTimeout(resolve, 3));
      }
    } else {
      let tempo = gesturedZone.style.transform.match(/\d+/)[0];
      while(tempo != 150) {
        if (tempo > 150 ) {
          tempo--;
          iconZone.style.width = `${tempo}px`;
          gesturedZone.style.transform = `translateX(-${tempo}px)`;
        } else {
          tempo++;
          gesturedZone.style.transform = `translateX(${tempo}px)`;
        }

        await new Promise(resolve => setTimeout(resolve, 3));
      }
    }

    // if (Math.abs(touchendX - touchstartX) > 150){
    //   let myAnim2 = gesturedZone.animate([
    //     { transform: `translateX(-${150}px)` }
    //   ], {
    //     duration: 500,
    //     iterations: 1,
    //     fill: "forwards",
    //     easing: "ease-in-out"
    //   });
    //   iconZone.animate([
    //     { width: `${160}px` }
    //   ], {
    //     duration: 500,
    //     iterations: 1,
    //     fill: "forwards",
    //     easing: "ease-in-out"
    //   });
    //   myAnim2.finished.then(() => {
    //     gesturedZone.style.transform = `translateX(${150}px)`;
    //     iconZone.setAttribute("style", `width: ${150}px; visibility: visible;`)
    //   });
    // } else {
    //   gesturedZone.animate([
    //     { transform: `translateX(${0}px)` }
    //   ], {
    //     duration: 500,
    //     iterations: 1,
    //     fill: "forwards",
    //     easing: "ease-in-out"
    //   });
    //   let myAnim = iconZone.animate([
    //     { width: `${0}px` }
    //   ], {
    //     duration: 500,
    //     iterations: 1,
    //     fill: "forwards",
    //     easing: "ease-in-out"
    //   })
    //   myAnim.finished.then(() => {
    //     gesturedZone.style.transform = `translateX(${0}px)`;
    //     iconZone.setAttribute("style", `width: ${0}px; visibility: hidden;`)
    //   });
    // }
  }, false);
});

  }
}
