import 'package:flutter/widgets.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/new_expense_template.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/models/participants.dart';

class NewExpenseTemplateState {
  NewExpenseTemplateStateEnum step;
  NewExpenseTemplateData? tempData;
  Participants? searchResult;
  TextEditingController? searchQuery = TextEditingController();
  TextEditingController? otherIntentController = TextEditingController();

  NewExpenseTemplateState(
      {this.step = NewExpenseTemplateStateEnum.type,
      this.tempData,
      this.searchQuery,
      this.otherIntentController,
      this.searchResult});
}
