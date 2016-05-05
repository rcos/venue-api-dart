import 'package:flutter/http.dart' as http;
import 'package:flutter/material.dart';
import 'api.dart';

class TestApp extends StatefulWidget {
  @override
  TestAppState createState() => new TestAppState();
}

class TestAppState extends State<TestApp> {
  @override
  void initState() {
    super.initState();
    var venueAPI = new VenueAPI("http://104.131.185.159:9000/");
    venueAPI.authenticate("jane@jane.com", "jane").then((dynamic a){
      print("Authenticated");
    }).catchError((err){
      print("Error while authenticating $err");
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Venue',
      routes: <String, WidgetBuilder>{
         '/':         (BuildContext context) => new Home(),
      }
    );
  }
}

class Home extends StatefulWidget {
  const Home();

  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context){
    return new Text("asd");
  }
}

void main() {
  runApp(new TestApp());
}
