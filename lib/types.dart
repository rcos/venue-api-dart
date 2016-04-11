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

  String enrollmentPolicy;

  CourseInfo course;

  List<int> sectionNumbers;
  List<UserInfo> students;
  List<UserInfo> pendingStudents;
  List<UserInfo> instructors;

  SectionInfo(Map info):super(info["_id"]){
    if (info["course"]){
      course = new CourseInfo(info['course']);
    }
    enrollmentPolicy = info['enrollmentPolicy'];
    sectionNumbers = info['sectionNumbers'];
    if (info["instructors"]){
      instructors = info['instructors'].map((Map ui) => new UserInfo(ui));
    }
    if (info["students"]){
      students = info['students'].map((Map ui) => new UserInfo(ui));
    }

    // pendingStudents = info['pendingStudents'].map((Map ui) => new UserInfo(ui));

  }
}

/*
 * Submission Information Object
 */
class SubmissionInfo extends DBItem{

  List<String> images;
  List<UserInfo> authors;
  SectionInfo sectionEvent;
  String content;
  DateTime time;
  UserInfo submitter;
  // Location location;

  SubmissionInfo(Map info):super(info["_id"]){
    images = info['images'];
    authors = info['authors'].map((Map ui) => new UserInfo(ui));
    sectionEvent = new SectionInfo(info['sectionEvent']);
    content = info['content'];
    // time = new DateTime(info['time']);
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
