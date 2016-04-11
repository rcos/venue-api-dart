# Venue Interface Dart

A dart library for interfacing the [Venue API](github.com/rcos/venue).

## Usage

```dart
_api = new VenueAPI("http://127.0.0.1:9000");

_api.authenticate("jane@jane.com", "jane").whenComplete((){
  print("Authenticated!");
  _api.getMe().then((UserInfo me){
    print("My name is ${me.firstName} ${me.lastName}");
  });
});

```

See the `main.dart` file for more example usage.

## What Works

* /users/me

## TODOs

* GET /users/:id
* GET /courses/:id
* POST /courses/
* GET /sections?onlyUser=me
* GET /sections?onlyUser=:id
* GET /sections
* GET /submissions?onlyStudent=me
* GET /submissions (all options)
* GET /sectionevents
