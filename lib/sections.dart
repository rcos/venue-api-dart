import 'util.dart';
import 'dart:async';
import "types.dart";

Future<List<SectionInfo>> getMySections(APIRequester api){
  return api.get("/sections",
  urlParams: {
    "onlyUser": "me",
    "withSectionsEvent": "true", // TODO these flags should be passed in
    "withSectionsCourse": "true",
    "withSectionsInstructors": "true",
    "withSectionsStudents": "true",
    "withSectionsPendingStudents": "false"
  }).then((List<Map> res){
    // TODO This endpoint is current broken
    return res.map((Map info) => new SectionInfo(info)).toList();
  });
}
