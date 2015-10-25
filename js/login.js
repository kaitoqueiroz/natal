function fb_login() {
	FB.login( function(login_dados) {
		var token = login_dados.authResponse.accessToken;
		FB.api(
			'/me',
			'GET',
			{
				"access_token":token,
				"fields":"location,relationship_status,cover,education,name,id",
			},
			function(dados) {
				console.log(dados);
				document['NatalGazinVideo'].setNome(dados.name);
				if (dados.cover) {
					document['NatalGazinVideo'].setFotoCapa(dados.cover.source,dados.cover.offset_y);
				}else{
					document['NatalGazinVideo'].setFotoCapa(null,0);
				}
				if (dados.education) {
					document['NatalGazinVideo'].setEnsino(dados.education[dados.education.length-1].school.name);
				};
				if (dados.location) {
					document['NatalGazinVideo'].setLocal(dados.location.name);
				};
				if (dados.relationship_status) {
					var traduziro = '';
					var rel = dados.relationship_status;
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
				$('.desejo-selecionado').each(function() {
                    desejos.push($(this).html());
                });
      //document['NatalGazinVideo'].setDesejos(['Geladeira','Televisão LED','Fogão','Armário','Cama King size']);
      document['NatalGazinVideo'].setDesejos(desejos);

      FB.api("/"+dados.id+"/picture?width=100&height=100",
      	function (foto_perfil) {
      		if (foto_perfil && !foto_perfil.error) {
      			console.log(foto_perfil)
      			document['NatalGazinVideo'].setAvatar(foto_perfil.data.url);
      			FB.api("/"+dados.id+"/picture?type=large",
      				function (foto_perfil_grande) {
      					console.log(foto_perfil_grande);
      					$('.top').hide();
      					$('.fullscreen-bg').hide();
      					$('.logo_gazin').hide();
      					$('.botao-login').hide();
      					$('.middle').hide();
      					$('.desejos').hide();
      					$('#video_natal').css('left','0px');
      					if (foto_perfil_grande && !foto_perfil_grande.error) {
      						document['NatalGazinVideo'].setFotoPerfil(foto_perfil_grande.data.url);
      						document['NatalGazinVideo'].playVideo();
      						console.log(foto_perfil_grande);
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