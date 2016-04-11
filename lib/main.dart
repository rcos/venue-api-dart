import "auth.dart" as auth;
import "users.dart" as users;
import "types.dart";
import "util.dart";
export "api.dart";
import 'dart:io';
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

}

VenueAPI _api;

main(){
  // Initialize the API
  _api = new VenueAPI("http://127.0.0.1:9000");

  // Begin running examples
  exAuthenticate();
}

// Authenticate with email and password
void exAuthenticate(){
  _api.authenticate("jane@jane.com", "jane").whenComplete((){
    print("Authenticated!");
    exBasicUserInfo();
  });
}

// Let's get information about myself
void exBasicUserInfo(){
  _api.getMe().then((UserInfo me){
    print("My name is ${me.firstName} ${me.lastName}");
    exGetMyCourses();
  });
}

// What courses am i taking?
void exGetMyCourses(){
  _api.getMe(withCourses: true).then((UserInfo me){
    print("I'm taking ${me.courses.length} courses.");
    me.courses.forEach((CourseInfo course){
      print("${course.name}");
    });
  });
}
