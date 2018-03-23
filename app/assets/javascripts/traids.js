document.addEventListener('turbolinks:load', function(){

  highlight($('#current-user-traid-copy'), $('requested-user-traid-copy'));
  
  function highlight(oldElem,newElem){
    var oldText = oldElem.text();
    var newText = newElem.text();
    
    var text = "";
    
    newElem.text().split(" ").forEach(function(value,index){
    
      if (value != oldText.charAt(index)){
          text += "<span class='highlight'>" + value + "</span>";
      }
      else {
          text += (value + " ");
      }
    });
    newElem.html(text)
  }
});