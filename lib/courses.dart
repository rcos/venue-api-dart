import 'util.dart';
import 'dart:async';
import "types.dart";

Future<CourseInfo> getCourse(APIRequester api, String courseId,
  {bool withSections, bool withSectionInstructors,
  bool withSectionEnrollmentStatus, String studentId}){
  return api.get("/courses/$courseId",
    urlParams: {
      "withSections": withSections,
      "withSectionInstructors": withSectionInstructors,
      "withSectionEnrollmentStatus": withSectionEnrollmentStatus,
      "studentid": studentId
    }
  ).then((Map res){
    return new CourseInfo(res);
  });
}
