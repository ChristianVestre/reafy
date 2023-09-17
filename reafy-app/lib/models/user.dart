import 'dart:convert';

class GoogleUser {
  String? email;
  String? name;
  String? sub;
  String? company;
  String? picture;
  String? id;

  GoogleUser(
      {this.email, this.name, this.sub, this.company, this.picture, this.id});

  GoogleUser.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    sub = json['sub'];
    picture = json['picture'];
  }

  static Map<String, dynamic> toMap(GoogleUser model) => <String, dynamic>{
        'email': model.email,
        'name': model.name,
        'sub': model.sub,
        'company': model.company,
        'picture': model.picture,
      };

  static String serialize(GoogleUser model) =>
      json.encode(GoogleUser.toMap(model));

  static GoogleUser deserialize(String json) =>
      GoogleUser.fromJson(jsonDecode(json));
}

class ReafyUser {
  String? email;
  String? userName;
  int? userId;
  int? companyId;
  String? companyName;
  int? participantId;
  String? role;

  ReafyUser(
      {this.email,
      this.userName,
      this.userId,
      this.companyName,
      this.companyId,
      this.participantId,
      this.role});

  ReafyUser.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userName = json['userName'];
    userId = json['userId'];
    companyId = json['companyId'];
    companyName = json['companyName'];
    participantId = json['participantId'];
    role = json['role'];
  }

  static Map<String, dynamic> toMap(ReafyUser model) => <String, dynamic>{
        'email': model.email,
        'userName': model.userName,
        'userId': model.userId,
        'companyId': model.companyId,
        'companyName': model.companyName,
        'participantId': model.participantId,
        'role': model.role
      };

  static String serialize(ReafyUser model) =>
      json.encode(ReafyUser.toMap(model));

  static ReafyUser deserialize(String json) =>
      ReafyUser.fromJson(jsonDecode(json));
}
