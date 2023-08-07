import 'package:flutter/cupertino.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/participant.dart';

class NewExpenseTemplateData with ChangeNotifier {
  List<Participant>? participants;
  NewExpenseTemplateIntentEnum? intent;
  NewExpenseTemplateTypeEnum? type;

  NewExpenseTemplateData(
      {required this.participants, required this.intent, required this.type});
}
