import 'util.dart';
import 'dart:async';
import "types.dart";

Future<UserInfo> getMe(APIRequester api, {bool withCourses, bool withSections, bool withSectionsCourse, bool withEvents, bool withEventSections}){
  return api.get("/users/me",
    urlParams: {
      "withCourses": withCourses.toString(),
      "withSections": withSections.toString(),
      "withSectionsCourse": withSectionsCourse.toString(),
      "withEvents": withEvents.toString(),
      "withEventSections": withEventSections.toString()
    }
  ).then((Map res){
    return new UserInfo(res);
  });
}

Future<UserInfo> getUser(APIRequester api, String userId, {bool withCourses, bool withSections, bool withSectionsCourse, bool withEvents, bool withEventSections}){
  return api.get("/users/$userId",
    urlParams: {
      "withCourses": withCourses.toString(),
      "withSections": withSections.toString(),
      "withSectionsCourse": withSectionsCourse.toString(),
      "withEvents": withEvents.toString(),
      "withEventSections": withEventSections.toString()
    }
  ).then((Map res){
    return new UserInfo(res);
  });
}
