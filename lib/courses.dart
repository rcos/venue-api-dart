import 'util.dart';
import 'dart:async';
import "types.dart";

Future<CourseInfo> getCourse(APIRequester api, String courseId,
  {bool withSections, bool withSectionInstructors,
  bool withSectionEnrollmentStatus, String studentId}){
  return api.get("/courses/$courseId",
    urlParams: {
      "withSections": withSections.toString(),
      "withSectionInstructors": withSectionInstructors.toString(),
      "withSectionEnrollmentStatus": withSectionEnrollmentStatus.toString(),
      "studentid": studentId.toString()
    }
  ).then((Map res){
    return new CourseInfo(res);
  });
}
