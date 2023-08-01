import 'package:flutter/material.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/participant.dart';

import '../models/new_expense_template_state.dart';

class StateProvider with ChangeNotifier {
  final ExpenseTemplateState _expenseTemplateState = ExpenseTemplateState();

  ExpenseTemplateState get newExepenseTemplateState => _expenseTemplateState;

  updateNewExpenseTemplateParticipants(List<Participant> participants) {
    _expenseTemplateState.tempData?.participants = participants;
  }

  updateNewExpenseTemplateSearchResult(List<Participant> searchResult) {
    _expenseTemplateState.searchResult = searchResult;
  }

  updateNewExpenseTemplateStateStep(NewExpenseTemplateStateEnum newStep) {
    _expenseTemplateState.step = newStep;
    notifyListeners();
  }

  addNewExpenseTemplateParticipant(Participant participant) {
    _expenseTemplateState.tempData?.participants?.add(participant);
    notifyListeners();
  }

  removeNewExpenseTemplateParticipant(Participant participant) {
    _expenseTemplateState.tempData?.participants?.remove(participant);
    notifyListeners();
  }

  updateNewExpenseTemplateType(NewExpenseTemplateTypeEnum type) {
    _expenseTemplateState.tempData?.type = type;
  }
}
