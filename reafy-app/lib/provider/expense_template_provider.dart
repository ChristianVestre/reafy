import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/expense_template.dart';
import 'package:reafy/models/new_expense_template_state.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/models/response_data.dart';

class ExpenseTemplateProvider with ChangeNotifier {
  ResponseData responseData = ResponseData();
  bool isLoading = false;
  NewExpenseTemplateSearchFilterEnum searchFilter =
      NewExpenseTemplateSearchFilterEnum.none;
  final ExpenseTemplateState _expenseTemplateState = ExpenseTemplateState(
    tempData: NewExpenseTemplateData(
        participants: [
          Participant(
              participantName: "Christian Vestre",
              companyName: "Tyve",
              participantId: 123),
        ],
        intent: NewExpenseTemplateIntentEnum.meeting,
        type: NewExpenseTemplateTypeEnum.velferd),
  );

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

  resetSearchResult() {
    _expenseTemplateState.searchResult = responseData.participants!;
    searchFilter = NewExpenseTemplateSearchFilterEnum.none;
    notifyListeners();
  }

  updateSearchResultWithCompany(String company) {
    _expenseTemplateState.searchResult = responseData.participants!
        .where((item) =>
            item.companyName!.toLowerCase().startsWith(company.toLowerCase()))
        .toList();
    searchFilter = NewExpenseTemplateSearchFilterEnum.company;
    notifyListeners();
  }

  updateParticipants(List<Participant> participants) {
    _expenseTemplateState.tempData?.participants = participants;
    notifyListeners();
  }

  updateSearchResultWithParticipant(String searchQuery) {
    _expenseTemplateState.searchResult = responseData.participants!
        .where((item) => item.participantName!
            .toLowerCase()
            .startsWith(searchQuery.toLowerCase()))
        .toList();
    notifyListeners();
  }

  updateSelectedParticipants(Participant selectedParticipant) {
    Participant participant = _expenseTemplateState.searchResult
        .firstWhere((participant) => participant == selectedParticipant);
    participant.selected = !participant.selected!;
    notifyListeners();
  }

  updateStateStep(NewExpenseTemplateStateEnum newStep) {
    _expenseTemplateState.step = newStep;
    print(_expenseTemplateState.step);
    notifyListeners();
  }

  addParticipant(Participant participant) {
    _expenseTemplateState.tempData?.participants?.add(participant);
    notifyListeners();
  }

  removeParticipant(Participant participant) {
    _expenseTemplateState.tempData?.participants?.remove(participant);
    notifyListeners();
  }

  updateType(NewExpenseTemplateTypeEnum type) {
    _expenseTemplateState.tempData?.type = type;
    notifyListeners();
  }

  updateIntent(NewExpenseTemplateIntentEnum type) {
    _expenseTemplateState.tempData?.intent = type;
    notifyListeners();
  }
}
