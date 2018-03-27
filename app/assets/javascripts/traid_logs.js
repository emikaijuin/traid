document.addEventListener('turbolinks:load', function(){
    
  $('.traid-show-previous-traids-dates').click(function(e){
    if ( $(this).next().hasClass("is-hidden") ) {
      $(this).next().removeClass("is-hidden")
    } else {
      $(this).next().addClass("is-hidden")
    }
  });

});