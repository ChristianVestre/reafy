import 'dart:convert';

class User {
  String? email;
  String? name;
  String? company;
  String? picture;
  String? id;

  User({this.email, this.name, this.company, this.picture, this.id});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    company = json['email'].substring(
        json['email'].indexOf('@') + 1, json['email'].lastIndexOf('.'));
    picture = json['picture'];
    id = json['sub'];
  }

  static Map<String, dynamic> toMap(User model) => <String, dynamic>{
        'email': model.email,
        'name': model.name,
        'company': model.company,
        'picture': model.picture,
        'id': model.id,
      };

  static String serialize(User model) => json.encode(User.toMap(model));

  static User deserialize(String json) => User.fromJson(jsonDecode(json));
}
