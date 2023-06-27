import 'package:flutter/cupertino.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/participant.dart';

class NewExpenseObjectData with ChangeNotifier {
  ValueNotifier<List<Participant>> participants;
  String? intent;
  ValueNotifier<NewExpenseObjectTypeEnum> type;

  NewExpenseObjectData(
      {required this.participants, required this.intent, required this.type});
}
