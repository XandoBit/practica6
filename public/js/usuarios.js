(function() {  
   setInterval(
    function(){
      $.get('/listuser',
        function(response){
          $('#listuser').replaceWith(response);
        }
      );
    },
  5000);
})();



