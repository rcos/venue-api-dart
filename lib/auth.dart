import 'package:flutter/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'util.dart';

/*
 * Gets cookie with session and XSRF token so that auth can begin.
 * Returns a partial AuthorizationInfo (without auth token)
 */
Future<AuthorizationInfo> _getPreAuthSession(String domain){
  return http.get("$domain/api/courses")
    .then((http.Response res){
      print("\n\n\n Got preauth response");
      print("Getting preauth, ${res.statusCode}");
      print("${res.headers}");
      //print("${res.body}");
      print("\n\n\n");
      return new AuthorizationInfo(
        cookies: new CookieList(res.headers['set-cookie'])
      );
    });
}

/*
 * Makes request to auth with email and password and returns
 * the full authentication info
 */
Future<AuthorizationInfo> getAuthorizationInfo({String domain, String email, String password}){
  var completer = new Completer<AuthorizationInfo>();
  print("Getting auth info $domain $email $password");
  _getPreAuthSession(domain).then((AuthorizationInfo auth){
    print("Posting ${auth.getHeaders()} $domain");
    http
      .post("$domain/auth/local",
        headers: auth.getHeaders(jsonRequest: true),
        body: JSON.encode({
          "email": email,
          "password": password
        })
      )
      .then((http.Response res) {
        if (res!=null && res.statusCode != 401){
          var responseJSON = JSON.decode(res.body);
          auth.setLoginToken(responseJSON["token"]);
          completer.complete(auth);
        }else{
          completer.completeError("Error logging in ${res.body}");
        }
      })
      .catchError((dynamic error){
        // TODO better error msg
        completer.completeError("Error logging in: $error");
      });
  });
  return completer.future;
}
