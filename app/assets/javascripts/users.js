document.addEventListener("turbolinks:load", function() {
  // $('#hidden-review-form').css("visibility","hidden")

  $('.toggle-review-form').click(function(){
    $('#hidden-review-form').toggle();
  });
  
  $('#toggle-traid-form').click(function(){
    toggle_user_show_secondary_column()
  });
  
  $('#close-traid-form').click(function(){
    toggle_user_show_secondary_column()
  });
  
  function toggle_user_show_secondary_column(){
    $('#user-show-traid-form').toggle();
    $('#user-show-map-container').toggle();    
  }
  
  $('#user-form-is-seeking').val(removeExtraChars($('#user-form-is-seeking')))
  $('#user-form-is-offering').val(removeExtraChars($('#user-form-is-offering')))
  
  function removeExtraChars(element) {
    input = $(element).val()
    input = input.replace("[","")
    input = input.replace("]","")
    input = input.replace(/"/g, "")
    
    return input
  };
  
  
  var lat = parseFloat($('#lat').html())
  var long = parseFloat($('#long').html())
  var mapOptions = {
    zoom: 14,
    center: new google.maps.LatLng(lat, long),
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    draggable: false,
    disableDefaultUI: true

  }
  var map = new google.maps.Map(document.getElementById("user-show-additional-info"), mapOptions);
});

