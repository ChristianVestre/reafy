class Participant {
  String? companyName;
  String? participantName;
  int? participantId;
  bool? selected;

  Participant(
      {this.companyName,
      this.participantName,
      this.participantId,
      this.selected});

  Participant.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    participantName = json['participant_name'];
    participantId = json['participant_id'];
    selected = false;
  }
}
