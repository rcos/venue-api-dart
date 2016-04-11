import 'util.dart';
import 'dart:async';
import "types.dart";

Future<List<SubmissionInfo>> getMySubmissions(APIRequester api){
  return api.get("/submissions/",
  urlParams: {
    "onlyStudent": "me"
  }).then((List<Map> res){
    return res.map((Map si) => new SubmissionInfo(si));
  });
}
