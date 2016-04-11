import 'util.dart';
import 'dart:async';
import "types.dart";

Future<UserInfo> getMe(APIRequester api, {bool withCourses, bool withSections}){
  return api.get("/users/me",
    urlParams: {
      "withCourses": withCourses.toString(),
      "withSections": withSections.toString()
    }
  ).then((Map res){
    return new UserInfo(res);
  });
}

Future<UserInfo> getUser(APIRequester api, String userId, {bool withCourses, bool withSections}){
  return api.get("/users/$userId",
    urlParams: {
      "withCourses": withCourses.toString(),
      "withSections": withSections.toString()
    }
  ).then((Map res){
    return new UserInfo(res);
  });
}
