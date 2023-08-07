import 'package:flutter/widgets.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/expense_template.dart';
import 'package:reafy/models/participant.dart';

class ExpenseTemplateState {
  NewExpenseTemplateStateEnum step;
  NewExpenseTemplateData? tempData;
  List<Participant> searchResult;
  TextEditingController? searchQuery = TextEditingController();
  TextEditingController? otherIntentController = TextEditingController();

  ExpenseTemplateState(
      {this.step = NewExpenseTemplateStateEnum.list,
      this.tempData,
      this.searchQuery,
      this.otherIntentController,
      this.searchResult = const []});
}
