/*(function() {
  
   setInterval(
    function(){
      $.get('/listuser',
        function(response){

          $('#listuser').replaceWith(response);
        }
      );
    },
  1000);
})();*/

$('#text').keypress(
  function(e){
    if( e.keyCode==13 ){
      $.get('/send',{text:$('#text').val()});
      $('#text').val('');
    } 
  }
);

(function() {
  var last = 0;
  setInterval(
    function(){
      $.get('/update',{last:last},
        function(response){
          last = $('<p>').html(response).find('span').data('last');
          $('#chat').append(response);
        }
      );

    },
  1000);
})();

(function() {
  var las = 0;
  setInterval(
    function(){
      $.get('/listuser',{las:las},
        function(response){
          $("#nombre").html("");
          $('#nombre').html(response);
        }
      );

    },
  1000);
})();


$('#boton1').click(
   function(){
    $.get('/send',{text:$('#text').val()});
    $('#text').val('');
   }
);




