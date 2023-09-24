import 'package:reafy/models/participants.dart';

class ExpenseTemplate {
  String? intent;
  String? type;
  Participants? participants;
  int? expenseTemplateId;

  ExpenseTemplate(
      {this.intent, this.type, this.participants, this.expenseTemplateId});

  ExpenseTemplate.fromJson(Map<String, dynamic> json) {
    expenseTemplateId = json['expenseTemplateId'];
    intent = json['intent'];
    type = json['type'];
    participants = Participants.fromJson({"data": json['participants']});
  }
}
