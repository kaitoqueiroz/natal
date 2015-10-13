function fb_login() {
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