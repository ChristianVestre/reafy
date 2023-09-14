import 'package:reafy/models/participant.dart';

class Participants {
  List<String>? participantCompanies;
  List<Participant>? participants;

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
