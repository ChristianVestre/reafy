import 'package:reafy/models/participant.dart';

class Participants {
  List<Participant>? participants;

  Participants({this.participants});

  Participants.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      participants = <Participant>[];
      json['data'].forEach((v) {
        participants!.add(Participant.fromJson(v));
      });
    }
  }
}
