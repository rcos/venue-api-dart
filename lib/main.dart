import "types.dart";
import "api.dart";

VenueAPI _api;

main(){
  // Initialize the API
  _api = new VenueAPI("http://127.0.0.1:9000");

  // Begin running examples
  exAuthenticate();
}

// Authenticate with email and password
void exAuthenticate(){
  _api.authenticate("jane@jane.com", "jane").whenComplete((){
    print("Authenticated!");
    exBasicUserInfo();
  });
}

// Let's get information about myself
void exBasicUserInfo(){
  _api.getMe().then((UserInfo me){
    print("My name is ${me.firstName} ${me.lastName}");
    exGetMyCourses();
  });
}

// What courses am i taking?
void exGetMyCourses(){
  _api.getMe(withCourses: true).then((UserInfo me){
    print("I'm taking ${me.courses.length} courses.");
    me.courses.forEach((CourseInfo course){
      print("${course.name}");
    });
    exQueryForCourse();
  });
}

// Getting course details
void exQueryForCourse(){
  _api.getCourse("000000000000000000000010").then((CourseInfo course){
    print("${course.name} is in the ${course.department} department");
    exGetMySubmissions();
  });
}

// TODO getting sections is currently broken (fix when Venue is fixed)
// void exGetMySections(){
//   _api.getMySections().then((List<SectionInfo> sections){
//   });
// }

// List everything I've submitted
void exGetMySubmissions(){
  _api.getMySubmissions().then((List<SubmissionInfo> submissions){
    print("I've submitted all of the following...");
    submissions.forEach((SubmissionInfo submission){
      print("${submission.content}");
    });
  });
}
