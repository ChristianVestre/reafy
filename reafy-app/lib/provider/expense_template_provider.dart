import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/models/response_data.dart';

import '../models/new_expense_template_state.dart';

class ExpenseTemplateProvider with ChangeNotifier {
  ResponseData responseData = ResponseData();
  bool isLoading = false;
  final ExpenseTemplateState _expenseTemplateState = ExpenseTemplateState();

  ExpenseTemplateState get expenseTemplateState => _expenseTemplateState;

  getParticipantList() async {
    isLoading = true;
    responseData = await getAllData();
    _expenseTemplateState.searchResult = responseData.participants!;
    isLoading = false;
    notifyListeners();
  }

  Future<ResponseData> getAllData() async {
    try {
      final response = await http.get(Uri.parse(
          "https://reafy-christianvestre.vercel.app/api/whitelist/get-people-whitelist"));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        responseData = ResponseData.fromJson(item);
        notifyListeners();
      } else {
        print("else");
      }
    } catch (e) {
      log(e.toString());
    }

    return responseData;
  }

  updateNewExpenseTemplateParticipants(List<Participant> participants) {
    _expenseTemplateState.tempData?.participants = participants;
    notifyListeners();
  }

  updateNewExpenseTemplateSearchResult(String searchQuery) {
    _expenseTemplateState.searchResult = responseData.participants!
        .where((item) => item.participantName!
            .toLowerCase()
            .startsWith(searchQuery.toLowerCase()))
        .toList();
    notifyListeners();
  }

  updateNewExpenseTemplateSelectedParticipants(
      Participant selectedParticipant) {
    Participant participant = _expenseTemplateState.searchResult
        .firstWhere((participant) => participant == selectedParticipant);
    participant.selected = !participant.selected!;
    notifyListeners();
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
