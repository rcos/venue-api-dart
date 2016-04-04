import 'util.dart';
import 'courses.dart';
import 'dart:async';

class UserInfo extends DBItem{

  String firstName, lastName, email, role;
  bool isInstructor;

  List<CourseInfo> courses;

  UserInfo(Map info):super(info['_id']){

    firstName = info['firstName'];
    lastName = info['lastName'];
    email = info['email'];
    role = info['role'];

    if (info['courses'] != null){
      courses = info['courses'].map((Map ci) => new CourseInfo(ci));
    }
  }
}

Future<UserInfo> getMe(APIRequester api){
  return api.get("/users/me", urlParams: {"withCourses":"true"}).then((Map res){
    return new UserInfo(res);
  });
}
