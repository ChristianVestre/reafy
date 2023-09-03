import 'package:flutter/cupertino.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/participants.dart';

class NewExpenseTemplateData with ChangeNotifier {
  Participants? participants;
  ExpenseTemplateIntentEnum? intent;
  ExpenseTemplateTypeEnum? type;

  NewExpenseTemplateData(
      {this.participants, required this.intent, required this.type});
}
