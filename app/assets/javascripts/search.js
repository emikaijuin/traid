document.addEventListener('turbolinks:load', function(){
  $('#submit-distance-filter').click(function(e){
    e.preventDefault();
    var maxDistance = parseInt($('#max-distance').val());
    
    $('.distance').each(function(i, obj){
        var distance = parseFloat($(obj).html())
          if (distance > maxDistance) {
            $(obj).parent().css("display","none")
          } else {
            $(obj).parent().css("display","block")
          }
    });
  });
});

