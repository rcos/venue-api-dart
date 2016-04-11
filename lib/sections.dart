import 'util.dart';
import 'dart:async';
import "types.dart";

Future<SectionInfo> getMySections(APIRequester api){
  return api.get("/sections",
  urlParams: {
    "onlyCurrentUser": true
  }).then((Map res){
    return new SectionInfo(res);
  });
}
