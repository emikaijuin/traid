$(document).ready(function(){
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
    $('#user-show-additional-info').toggle();    
  }
});

