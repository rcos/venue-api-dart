import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';

String endpoint(ext) => "http://127.0.0.1:9000$ext";

/*
 * Stores all the information needed to make authenticated requests
 * to venue
 */
class AuthorizationInfo{
  CookieList cookies;
  String xsrfToken;
  String loginToken;
  AuthorizationInfo({this.cookies}){
    xsrfToken = Uri.decodeFull(cookies["XSRF-TOKEN"].value);
  }
  void setLoginToken(String token){
    loginToken = token;
    cookies["token"] = new Cookie("token", token);
  }
  Map<String,String> getHeaders(){
    return {
      "Cookie" : cookies.toString(),
      "Authorization" : "Bearer $loginToken",
      "X-XSRF-TOKEN" : xsrfToken
    };
  }
}

/*
 * Utility class to store and manipulate cookies
 */
class CookieList{
  Map<String,Cookie> cookieMap;
  CookieList(String cookieString){
    cookieMap = new Map<String,Cookie>();
    cookieString.split(";").forEach((String sc){
      sc.split(",").forEach((String kv){
        try{
          var cookie = new Cookie.fromSetCookieValue(kv.trim());
          cookieMap[cookie.name.trim()] = cookie;
        }catch(e){
          //invalid cookie
        }
      });
    });
  }
  operator [](String i){
    return cookieMap[i];
  }
  operator []=(String i, Cookie val){
    cookieMap[i] = val;
  }
  String toString(){
    return cookieMap.values.map((Cookie cookie){
      return "${cookie.name}=${cookie.value};";
    }).reduce((String c1, String c2) => c1 + c2);
  }
}


/*
 * Gets cookie with session and XSRF token so that auth can begin.
 * Returns a partial AuthorizationInfo (without auth token)
 */
Future<AuthorizationInfo> _getPreAuthSession(){
  return new http.Client().get(endpoint("/api/courses"))
    .then((http.Response res){
      return new AuthorizationInfo(
        cookies: new CookieList(res.headers['set-cookie'])
      );
    });
}

/*
 * Makes request to auth with email and password and returns
 * the full authentication info
 */
Future<AuthorizationInfo> getAuthorizationInfo(String email, String password){
  var completer = new Completer<AuthorizationInfo>();
  _getPreAuthSession().then((AuthorizationInfo auth){
    new http.Client()
      .post(endpoint("/auth/local"),
        headers: auth.getHeaders(),
        body: {
          "email": email,
          "password": password
        }
      ).then((http.Response res) {
        var responseJSON = JSON.decode(res.body);
        auth.setLoginToken(responseJSON["token"]);
        completer.complete(auth);
      });
  });
  return completer.future;
}
