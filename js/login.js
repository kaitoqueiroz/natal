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
	FB.login( function(login_response) {
		var token = login_response.authResponse.accessToken;
		FB.api(
			'/me',
			'GET',
			{
				"access_token":token,
				"fields":"location,relationship_status,cover,education,name,id",
			},
			function(response) {
				console.log(response);
				document['NatalGazinVideo'].setNome(response.name);
				if (response.cover) {
					document['NatalGazinVideo'].setFotoCapa(response.cover.source,response.cover.offset_y);
				}else{
					document['NatalGazinVideo'].setFotoCapa(null,0);
				}
				if (response.education) {
					document['NatalGazinVideo'].setEnsino(response.education[response.education.length-1].school.name);
				};
				if (response.location) {
					document['NatalGazinVideo'].setLocal(response.location.name);
				};
				if (response.relationship_status) {
					var traduziro = '';
					var rel = response.relationship_status;
					if (rel=='Single') {traduziro = 'Solteiro(a)'}
					else if (rel=='In a relationship') {traduziro = 'Em um relacionamento sério'}
					else if (rel=='Engaged') {traduziro = 'Noivo(a)'}
					else if (rel=='Married') {traduziro = 'Casado(a)'}
					else if (rel=="It's complicated") {traduziro = 'Em um relacionamento complicado'}
					else if (rel=='In an open relationship') {traduziro = 'Em um relacionamento aberto'}
					else if (rel=='Widowed') {traduziro = 'Viuvo(a)'}
					else if (rel=='Separated') {traduziro = 'Separado(a)'}
					else if (rel=='Divorced') {traduziro = 'Divorciado(a)'}
					else if (rel=='In a civil union') {traduziro = 'Em uma união civil'}
					else {traduziro =  rel};

					document['NatalGazinVideo'].setRelacionamento(traduziro);
				};
				var desejos = [];
				$('[name="checkbox[]"]:checked').each(function() {
					desejos.push($(this).val());
				});
      //document['NatalGazinVideo'].setDesejos(['Geladeira','Televisão LED','Fogão','Armário','Cama King size']);
      document['NatalGazinVideo'].setDesejos(desejos);

      FB.api("/"+response.id+"/picture?width=100&height=100",
      	function (response2) {
      		if (response2 && !response2.error) {
      			console.log(response2)
      			document['NatalGazinVideo'].setAvatar(response2.data.url);
      			FB.api("/"+response.id+"/picture?type=large",
      				function (response3) {
      					console.log(response3);
      					$('.back').hide();
      					$('#snow').hide();
      					$('.fullscreen-bg').hide();
      					$('.logo_natal').hide();
      					$('.logo_gazin').hide();
      					$('#video_natal').css('left','0px');
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
{ scope: 'user_relationships, user_location, user_education_history, public_profile' } );
}