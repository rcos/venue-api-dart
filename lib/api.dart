import "auth.dart" as auth;
import "users.dart" as users;
import "courses.dart" as courses;
import "sections.dart" as sections;
import "submissions.dart" as submissions;
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

   /*
    * Gets course by id
    */
    Future<CourseInfo> getCourse(courseId,
      {bool withSections, bool withSectionInstructors,
      bool withSectionEnrollmentStatus, String studentId}){
      return courses.getCourse(api, courseId,
        withSections: withSections,
        withSectionInstructors: withSectionInstructors,
        withSectionEnrollmentStatus: withSectionEnrollmentStatus,
        studentId: studentId
      );
    }


  /*
   * Gets sections for current user
   */
   Future<SectionInfo> getMySections(){
     return sections.getMySections(api);
   }

   /*
    * Gets submissions for current user
    */
    Future<SubmissionInfo> getMySubmissions(){
      return submissions.getMySubmissions(api);
    }

}
