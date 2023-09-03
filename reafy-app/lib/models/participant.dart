class Participant {
  int? companyId;
  String? companyName;
  String? participantName;
  int? participantId;
  String? relation;
  bool? selected;

  Participant(
      {this.companyId,
      this.companyName,
      this.participantName,
      this.participantId,
      this.relation,
      this.selected});

  Participant.fromJson(Map<String, dynamic> json) {
    print(json);
    companyId = json['companyId'];
    companyName = json['companyName'];
    participantName = json['participantName'];
    participantId = json['participantId'];
    relation = json['relation'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'participantId': participantId,
      'participantName': participantName,
      'relation': relation,
      'companyId': companyId
    };
  }
}
