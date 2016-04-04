import "auth.dart" as auth;
import "users.dart" as users;
import "util.dart" as util;

main(){
  auth.getAuthorizationInfo(
    domain: "http://127.0.0.1:9000",
    email: "test@test.com",
    password: "test"
  ).then((authInfo){
    var api = new util.APIRequester("http://127.0.0.1:9000", authInfo);
    users.getMe(api).then((v) => print(v));
  });

}
