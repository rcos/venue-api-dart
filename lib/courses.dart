import "util.dart";

class CourseInfo extends DBItem{

  String name, department, description, semester;
  bool active;
  int courseNumber;

  CourseInfo(Map info):super(info["_id"]){
    name = info['name'];
    department = info['department'];
    description = info['description'];
    semester = info['semester'];
    active = info['active'];
    courseNumber = info['courseNumber'];
  }
}
