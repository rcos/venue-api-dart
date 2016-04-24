import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class Cookie{
  String name, value;
  Cookie(this.name, this.value);
  Cookie.fromSetCookieValue(String kv){
    var ar = kv.split("=");
    name = ar[0];
    value = ar[1];
  }
}

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
 * Utility class for making API calls without a ton of parameters
 */
class APIRequester{
  String domain;
  AuthorizationInfo authInfo;

  APIRequester(this.domain, this.authInfo);

  Future<dynamic> get(String endpoint, {
    Map<String, String> urlParams,
    body
  }) => req(domain, endpoint, "GET", urlParams, authInfo, body);

  Future<Map> post(String endpoint, {
    Map<String, String> urlParams,
    body
  }) => req(domain, endpoint, "POST", urlParams, authInfo, body);

  Future<Map> patch(String endpoint, {
    Map<String, String> urlParams,
    body
  }) => req(domain, endpoint, "PATCH", urlParams, authInfo, body);

  Future<Map> delete(String endpoint, {
    Map<String, String> urlParams,
    body
  }) => req(domain, endpoint, "DELETE", urlParams, authInfo, body);

  Future<Map> put(String endpoint, {
    Map<String, String> urlParams,
    body
  }) => req(domain, endpoint, "PUT", urlParams, authInfo, body);

}

/*
 * Utility function for making api requests post-auth, see
 * auth.getAuthorizationInfo for getting authenticated
 */
Future<dynamic> req(String domain, String endpoint, String method,
                    Map<String,String> urlParams, AuthorizationInfo authInfo,
                    Map payload){
  Function requestFunction;
  switch(method.toUpperCase()){
    case "POST":
    requestFunction = new http.Client().post;
    break;
    case "PUT":
    requestFunction = new http.Client().put;
    break;
    case "PATCH":
    requestFunction = new http.Client().patch;
    break;
    case "GET":
    requestFunction = (String url, {Map headers, Map body}){
      return new http.Client().get(url, headers: headers);
    };
    break;
    case "DELETE":
    requestFunction = new http.Client().delete;
    break;
  }
  String urlParamsString;
  if (urlParams != null){
    urlParamsString = urlParams.keys.map((String k){
      return "${Uri.encodeFull(k)}=${Uri.encodeFull(urlParams[k])}&";
    }).reduce((String a, String b) => a + b);
  }else{
    urlParamsString = "";
  }
  return requestFunction("$domain/api$endpoint?$urlParamsString",
    headers: authInfo.getHeaders(),
    body: payload
  ).then((res){
    try{
      return JSON.decode(res.body);
    }catch(err){
      print("ERROR: $method $endpoint");
      print("RESPONSE: ${res.body}");
    }
  });
}
