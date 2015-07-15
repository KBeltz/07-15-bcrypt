// Get the DOM reference
var hamburger = document.getElementById("hamburger");
var navMenu = document.getElementById("nav_menu");

// Toggle
function toggleContent() {
  navMenu.addEventListener("animationstart", 'click', false);
  navMenu.addEventListener("animationend", 'click', false);
  navMenu.style.display == "block" ? navMenu.style.display = "none" : navMenu.style.display = "block";
}

hamburger.onclick = toggleContent;

navMenu.className = "slidein";
