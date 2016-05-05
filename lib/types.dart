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
    if (info.containsKey("course")){
      course = new CourseInfo(info['course']);
    }
    enrollmentPolicy = info['enrollmentPolicy'];
    sectionNumbers = info['sectionNumbers'];
    if (info.containsKey("instructor")){
      instructors = info['instructors'].map((Map ui) => new UserInfo(ui)).toList();
    }
    if (info.containsKey("students")){
      // The API sometimes returns a string to indicate ids and sometimes
      // returns an object, I think this should be fixed in the API
      // students = info['students'].map((Map ui) => new UserInfo(ui)).toList();
    }

    // pendingStudents = info['pendingStudents'].map((Map ui) => new UserInfo(ui));

  }
}

/*
 * Event Information Object
 */
class EventInfo extends DBItem{

  String author;
  DateTime creationDate;
  String description;
  List<String> imageURLs;
  Map location; // TODO location type
  List<EventAssignment> eventAssignments;

  EventInfo(Map info):super(info["_id"]){
    author = info['author'];
    // creationDate = new DateTime(...); TODO
    description = info['description'];
    imageURLs = info['imageURLs'];
    location = info['location'];

    if (info.containsKey("sectionEvents")){
      eventAssignments = info["sectionEvents"].map((Map evnt) => new EventAssignment(evnt)).toList();
    }
  }

}

/*
 * Event Assignment Information Object
 */
class EventAssignment extends DBItem{

  SectionInfo section;
  String author;
  DateTime creationDate;
  String instructions;

  EventAssignment(Map info): super(info["_id"]){

    section = new SectionInfo(info['section']);
    author = info['author'];
    // creationDate = new DateTime(...);
    instructions = info['submissionInstructions'];

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
  List<SectionInfo> sections;
  List<EventInfo> events;

  UserInfo(Map info):super(info['_id']){

    firstName = info['firstName'];
    lastName = info['lastName'];
    email = info['email'];
    role = info['role'];

    if (info.containsKey("courses")){
      courses = info['courses'].values.map((Map info) => new CourseInfo(info)).toList();
    }

    if (info.containsKey("sections")){
      sections = info['sections'].map((Map si) => new SectionInfo(si)).toList();
    }

    if (info.containsKey("events")){
      events = info['events'].values.map((Map ei) => new EventInfo(ei)).toList();
    }

  }
}
