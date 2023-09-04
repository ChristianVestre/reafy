import 'package:flutter/widgets.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/new_expense_template.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/models/participants.dart';

class ExpenseTemplate {
  ExpenseTemplateIntentEnum? intent;
  ExpenseTemplateTypeEnum? type;
  Participants? participants;
  int? expenseTemplateId;

  ExpenseTemplate(
      {this.intent, this.type, this.participants, this.expenseTemplateId});

  ExpenseTemplate.fromJson(Map<String, dynamic> json) {
    expenseTemplateId = json['expenseTemplateId'];
    intent = ExpenseTemplateIntentEnum.values
        .firstWhere((e) => e.stringValues == json['intent']);
    type = ExpenseTemplateTypeEnum.values
        .firstWhere((e) => e.stringValues == json['type']);
    participants = Participants.fromJson({"data": json['participants']});
  }
}
