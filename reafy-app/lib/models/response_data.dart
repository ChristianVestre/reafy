import 'package:reafy/models/participant.dart';

class ResponseData {
  List<Participant>? participants;

  ResponseData({this.participants});

  ResponseData.fromJson(Map<String, dynamic> json) {
    if (json['body'] != null) {
      participants = <Participant>[];
      json['body'].forEach((v) {
        participants!.add(Participant.fromJson(v));
      });
    }
  }
}
