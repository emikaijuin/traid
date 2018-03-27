document.addEventListener("turbolinks:load", function() {
 var mapOptions = {
    zoom: 14,
    center: new google.maps.LatLng(37.76, -122.4194),
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    draggable: false,
    disableDefaultUI: true

  }
  var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
});