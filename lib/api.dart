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
class VenueAPI {
  // For local instances, the domain is http://127.0.0.1:9000
  String domain;
  // APIRequester object to simplify api requests
  APIRequester api;

  VenueAPI(this.domain){
    if (domain.endsWith("/")){
      domain = domain.substring(0,domain.length-1);
    }
  }

  /*
   * Authentication call, call this before any other API request
   */
  Future authenticate(String email, String password) {
    print("Sending email:\"$email\" and pw:\"$password\"");
    return auth
        .getAuthorizationInfo(domain: domain, email: email, password: password)
        .then((authInfo) {
      api = new APIRequester(domain, authInfo);
    });
  }

  /*
   * Returns information about self for logged in user
   */
  Future<UserInfo> getMe({bool withCourses, bool withSections, bool withSectionsCourse, bool withEvents, bool withEventSections}) {
    return users.getMe(api,
        withCourses: withCourses, withSections: withSections,
        withSectionsCourse: withSectionsCourse, withEvents: withEvents,
        withEventSections: withEventSections);
  }

  /*
   *  Gets information about requested user
   */
  Future<UserInfo> getUser(String userId, {bool withCourses, bool withSections, bool withSectionsCourse, bool withEvents, bool withEventSections}) {
    return users.getUser(api, userId,
        withCourses: withCourses, withSections: withSections,
        withSectionsCourse: withSectionsCourse, withEvents: withEvents,
        withEventSections: withEventSections);
  }

  /*
    * Gets course by id
    */
  Future<CourseInfo> getCourse(String courseId,
      {bool withSections,
      bool withSectionInstructors,
      bool withSectionEnrollmentStatus,
      String studentId}) {
    return courses.getCourse(api, courseId,
        withSections: withSections,
        withSectionInstructors: withSectionInstructors,
        withSectionEnrollmentStatus: withSectionEnrollmentStatus,
        studentId: studentId);
  }

  /*
   * Gets sections for current user
   */
  Future<List<SectionInfo>> getMySections() {
    return sections.getMySections(api);
  }

  /*
    * Gets submissions for current user
    */
  Future<List<SubmissionInfo>> getMySubmissions() {
    return submissions.getMySubmissions(api);
  }
}
