import "types.dart";
import "api.dart";

VenueAPI _api;

main(){
  // Initialize the API
  _api = new VenueAPI("http://127.0.0.1:9000");

  // Begin running examples
  exAuthenticate();
}

// Authenticate with username and email
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
  });
}
