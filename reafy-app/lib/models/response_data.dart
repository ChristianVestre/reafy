class ResponseData {
  List<Data>? data;

  ResponseData({this.data});

  ResponseData.fromJson(Map<String, dynamic> json) {
    if (json['body'] != null) {
      data = <Data>[];
      json['body'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? companyName;
  String? participantName;
  int? participantId;

  Data({
    this.companyName,
    this.participantName,
    this.participantId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    participantName = json['participant_name'];
    participantId = json['participant_id'];
  }
}
