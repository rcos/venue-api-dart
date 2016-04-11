import "util.dart";

/*
 * Generic database items always have an immutable id, essentially every
 * item returned from the api is a database item
 */
class DBItem{
  String _id;
  DBItem(this._id);
  get id => _id;
}

/*
 * Course Information Object
 */
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

/*
 * Section Information Object
 */
class SectionInfo extends DBItem{

  String enrollmentPolicy, course;

  List<int> sectionNumbers;
  List<String> students;
  List<String> pendingStudents;
  List<String> instructors;

  SectionInfo(Map info):super(info["_id"]){
    course = info['course'];
    enrollmentPolicy = info['enrollmentPolicy'];
    instructors = info['instructors'];
    sectionNumbers = info['sectionNumbers'];

    pendingStudents = info['pendingStudents'];
    students = info['students'];

  }
}

/*
 * Submission Information Object
 */
class SubmissionInfo extends DBItem{

  List<String> images;
  List<UserInfo> authors;
  List<SectionInfo> sectionEvent;
  String content;
  DateTime time;
  UserInfo submitter;
  // Location location;

  SubmissionInfo(Map info):super(info["_id"]){
    images = info['images'];
    authors = info['authors'].map((Map ui) => new UserInfo(ui));
    sectionEvent = info['sectionEvent'].map((Map se) => new SectionInfo(se));
    content = info['content'];
    time = new DateTime(info['time']);
    submitter = info['submitter'];
    // location = new Location(info['location']);
  }
}

/*
 * User Information Object
 */
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

    if (info['courses'] != null){
      courses = info['courses'].map((Map ci) => new CourseInfo(ci));
    }

  }
}
