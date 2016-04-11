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

* Authentication
* /users/me
* `GET` /users/:id
* `GET` /courses/:id
* `GET` /submissions?onlyStudent=me

## TODOs

* `POST` /courses/
* `GET` /submissions (all options)
* `GET` /sections

## Can't current fix

* `GET` /sections?onlyUser=me
* `GET` /sections?onlyUser=:id
* `GET` /sectionevents
