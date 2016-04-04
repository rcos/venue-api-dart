import "util.dart";

class SectionInfo extends DBItem{

  String enrollmentPolicy, course;

  List<int> sectionNumbers;
  List<String> students;
  List<String> pendingStudents;
  List<String> instructors;

  SectionInfo(Map info):super(info["_id"]){

  }
}
