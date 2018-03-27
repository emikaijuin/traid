document.addEventListener("turbolinks:load", function() {
 var mapOptions = {
    zoom: 14,
    center: new google.maps.LatLng(42.3601, -71.0589),
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    draggable: false,
    disableDefaultUI: true
  }
  var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
});