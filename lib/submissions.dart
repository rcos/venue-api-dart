import 'util.dart';
import 'dart:async';
import "types.dart";

Future<SubmissionInfo> getMySubmissions(APIRequester api){
  return api.get("/submissions/",
  urlParams: {
    "onlyStudent": "me"
  }).then((Map res){
    return new SubmissionInfo(res);
  });
}
