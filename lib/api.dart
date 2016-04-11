import "auth.dart" as auth;
import "users.dart" as users;
import "types.dart";
import "util.dart";
import 'dart:async';

/*
 * API Object for external application use
 * TODO tons of documentation here
 */
class VenueAPI{

  // For local instances, the domain is http://127.0.0.1:9000
  String domain;
  // APIRequester object to simplify api requests
  APIRequester api;

  VenueAPI(this.domain);

  /*
   * Authentication call, call this before any other API request
   */
  Future authenticate(String email, String password){
    return auth.getAuthorizationInfo(
      domain: domain,
      email: email,
      password: password
    ).then((authInfo){
      api = new APIRequester(domain, authInfo);
    });
  }

  /*
   * Returns information about self for logged in user
   */
  Future<UserInfo> getMe({bool withCourses, bool withSections}){
    return users.getMe(api,
      withCourses: withCourses,
      withSections: withSections
    );
  }

  /*
   *  Gets information about requested user
   */
   Future<UserInfo> getUser(userId, {bool withCourses, bool withSections}){
     return users.getUser(api, userId,
       withCourses: withCourses,
       withSections: withSections
     );
   }

}
