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
  _getPreAuthSession(domain).then((AuthorizationInfo auth){
    http
      .post("$domain/auth/local",
        headers: auth.getHeaders(),
        body: {
          "email": email,
          "password": password
        }
      ).catchError((){
        // TODO better error msg
        completer.completeError("Could not log in");
      })
      .then((http.Response res) {
        var responseJSON = JSON.decode(res.body);
        auth.setLoginToken(responseJSON["token"]);
        completer.complete(auth);
      });
  });
  return completer.future;
}
