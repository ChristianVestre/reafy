class User {
  String? email;
  String? name;
  String? company;

  User({this.email, this.name, this.company});

  User.fromJson(Map<String, dynamic> json) {
    if (json['body'] != null) {
      email = json['body']['email'];
      name = json['body']['name'];
      company = json['body']['company'];
    }
  }
}
