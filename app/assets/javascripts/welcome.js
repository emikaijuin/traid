// $.ajax({
//   type: "GET",
//   url: "traids/recent_traid_locations",
//   dataType: "json",
//   success: function(result){
//     var coordinates_list = result;
//     append_markers_to_map(coordinates_list);
//   }
// });

// function append_markers_to_map(coordinates_list){
//   debugger
//   coordinates_list.forEach(function(el){
//     var circle = new google.maps.Marker({
//       strokeColor: '#FF0000',
//       strokeOpacity: 0.8,
//       strokeWeight: 2,
//       fillColor: '#FF0000',
//       fillOpacity: 0.35,
//       map: map,
//       center: {lat: el["lat"], lng: el["long"]},
//     });
    
// // google.maps.event.addDomListener(window, 'load', initialize);

//   });
// }
