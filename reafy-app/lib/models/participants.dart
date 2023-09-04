import 'package:reafy/models/participant.dart';

class Participants {
  List<Participant>? participants;
  List<String>? participantCompanies;

  Participants({this.participants, this.participantCompanies});

  Participants.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      participants = <Participant>[];
      participantCompanies = <String>[];
      json['data'].forEach((v) {
        participants!.add(Participant.fromJson(v));
        if (!participantCompanies!
            .any((element) => element == v['companyName'])) {
          participantCompanies!.add(v['companyName']);
        }
      });
    }
  }
}
