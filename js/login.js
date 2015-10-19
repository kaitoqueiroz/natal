/*function fb_login() {
  FB.login( function() {
    FB.api('/me', function(response) {
      FB.api(
          "/"+response.id+"/picture?width=100&height=100",
          function (response2) {
            if (response2 && !response2.error) {
              console.log(response);
              console.log(response2);
            }
          }
      );
      FB.api(
          "/"+response.id+"/picture?type=large",
          function (response2) {
            if (response2 && !response2.error) {
              console.log(response2);
            }
          }
      );
    });
  },
  { scope: 'email,public_profile' } );
}
*/

function fb_login() {
  FB.login( function() {
    FB.api('/me', function(response) {
      document['NatalGazinVideo'].setNome(response.name);
      var desejos = [];
      $('[name="checkbox[]"]:checked').each(function() {
       desejos.push($(this).val());
     	});
      //document['NatalGazinVideo'].setDesejos(['Geladeira','Televisão LED','Fogão','Armário','Cama King size']);
      document['NatalGazinVideo'].setDesejos(desejos);
      FB.api(
          "/"+response.id+"/picture?width=100&height=100",
          function (response2) {
            if (response2 && !response2.error) {
              document['NatalGazinVideo'].setAvatar(response2.data.url);
                FB.api(
                    "/"+response.id+"/picture?type=large",
                    function (response3) {
                    	$('.back').hide();
                    	$('#snow').hide();
                    	$('.fullscreen-bg').hide();
                    	$('.logo_natal').hide();
                    	$('.logo_gazin').hide();
                    	$('#video_natal').css('opacity',1);
                      if (response3 && !response3.error) {
                        document['NatalGazinVideo'].setFotoPerfil(response3.data.url);
                        document['NatalGazinVideo'].playVideo();
                        console.log(response3);
                      }
                    }
                );
            }
          }
      );
    });
  },
  { scope: 'email,public_profile' } );
}