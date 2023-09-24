class ExpenseCheck {
  String? type;

  ExpenseCheck({this.type});

  ExpenseCheck.fromJson(Map<String, dynamic> json) {
    print(json);
    type = json['type'];
  }
}
