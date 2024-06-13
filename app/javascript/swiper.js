// code not in use yet

// let touchstartX = 0;
// let touchcurrentX = 0;
// let touchendX = 0;
// let isDragging = false;

// let gesuredZones = document.querySelectorAll('.gestured-zone');

// gesuredZones.forEach(function(gesuredZone) {
//   gesuredZone.addEventListener('touchstart', function(event) {
//     isDragging = true;
//     touchstartX = event.changedTouches[0].screenX;
//   }, { passive: true });

//   gesuredZone.addEventListener('touchmove', function(event) {
//     if (!isDragging) return;
//     touchcurrentX = event.changedTouches[0].screenX;
//     const translateX = Math.min(0, touchcurrentX - touchstartX);
//     // console.log(translateX);
//     console.log("zoooooob");
//   }, { passive: true });

//   gesuredZone.addEventListener('touchend', function(event) {
//     if (!isDragging) return;
//     isDragging = false;
//     touchendX = event.changedTouches[0].screenX;
//     handleGesure();
//   }, false);
// });

// function handleGesure() {
//     let swiped = 'swiped: ';
//     if (touchendX < touchstartX) {
//         alert(swiped + 'left!');
//     }
//     if (touchendX > touchstartX) {
//         alert(swiped + 'right!');
//     }
// }
