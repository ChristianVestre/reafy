import 'dart:convert';
import 'dart:developer';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:reafy/helpers/constants.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/new_expense_template.dart';
import 'package:reafy/models/new_expense_template_state.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/models/participants.dart';
import 'package:reafy/provider/auth_provider.dart';

class ExpenseTemplateProvider with ChangeNotifier {
  ExpenseTemplateProvider(this.authProvider);
  final AuthProvider authProvider;

  Participants participantsResponse = Participants();
  bool isLoading = false;
  NewExpenseTemplateSearchFilterEnum searchFilter =
      NewExpenseTemplateSearchFilterEnum.none;
  final NewExpenseTemplateState _expenseTemplateState = NewExpenseTemplateState(
    tempData: NewExpenseTemplateData(
        participants: null,
        intent: ExpenseTemplateIntentEnum.meeting,
        type: ExpenseTemplateTypeEnum.velferd),
  );

  NewExpenseTemplateState get expenseTemplateState => _expenseTemplateState;

  getParticipantList() async {
    isLoading = true;
    participantsResponse = await getParticipants();
    print("participants");
    _expenseTemplateState.searchResult = participantsResponse;
    _expenseTemplateState.tempData!.participants = participantsResponse;
    isLoading = false;
    notifyListeners();
  }

  Future<Participants> getParticipants() async {
    try {
      final response =
          await http.get(Uri.parse('$baseApiUrl/participants?id=1'), headers: {
        "authorization":
            'Bearer ${JWT({}).sign(SecretKey(dotenv.env["SECRET_TOKEN"]!))}'
      });
      if (response.statusCode == 200) {
        final item = await json.decode(response.body);
        //            await json.decode(utf8.decode(response.body.runes.toList()));
        participantsResponse = Participants.fromJson(item);
        print(participantsResponse.participants);
        notifyListeners();
      } else {
        print("else");
      }
    } catch (e) {
      log(e.toString());
    }

    return participantsResponse;
  }

  submitExpenseTemplate(int createdBy) async {
    isLoading = true;
    participantsResponse = await postExpenseTemplate(createdBy);
    isLoading = false;
  }

  Future<Participants> postExpenseTemplate(int createdBy) async {
    final Map body = {
      "expenseIntent": _expenseTemplateState.tempData!.intent!.stringValues,
      "expenseType": _expenseTemplateState.tempData!.type!.stringValues,
      "participants": _expenseTemplateState.tempData?.participants!.participants
          ?.where((item) => item.selected == true)
          .toList(),
      "createdBy": authProvider.reafyUser.userId
    };
    final encodedBody = json.encode(body);

    try {
      final response = await http.post(
          Uri.parse('$baseApiUrl/expense/expense-template'),
          body: encodedBody,
          headers: {
            "authorization":
                'Bearer ${JWT({}).sign(key, algorithm: JWTAlgorithm.HS256)}'
          });
      print(response.statusCode);
    } catch (e) {
      log(e.toString());
    }
    return participantsResponse;
  }

  resetSearchResult() {
    _expenseTemplateState.searchResult = participantsResponse!;
    searchFilter = NewExpenseTemplateSearchFilterEnum.none;
    notifyListeners();
  }

  updateSearchResultWithCompany(String company) {
    _expenseTemplateState.searchResult = Participants(
        participants: participantsResponse!.participants!
            .where((item) => item.companyName!
                .toLowerCase()
                .startsWith(company.toLowerCase()))
            .toList());

    searchFilter = NewExpenseTemplateSearchFilterEnum.company;
    notifyListeners();
  }

  updateParticipants(Participants participants) {
    _expenseTemplateState.tempData?.participants = participants;
    notifyListeners();
  }

  updateSearchResultWithParticipant(String searchQuery) {
    _expenseTemplateState.searchResult = Participants(
        participants: participantsResponse.participants!
            .where((item) => item.participantName!
                .toLowerCase()
                .startsWith(searchQuery.toLowerCase()))
            .toList());
    notifyListeners();
  }

  updateSelectedParticipants(Participant selectedParticipant) {
    Participant participant = _expenseTemplateState.searchResult!.participants!
        .firstWhere((participant) => participant == selectedParticipant);
    participant.selected = !participant.selected!;
    notifyListeners();
  }

  updateStateStep(NewExpenseTemplateStateEnum newStep) {
    _expenseTemplateState.step = newStep;
    notifyListeners();
  }

  addParticipant(Participant participant) {
    _expenseTemplateState.tempData?.participants!.participants!
        .remove(participant);

    notifyListeners();
  }

  removeParticipant(Participant participant) {
    _expenseTemplateState.tempData?.participants!.participants!
        .remove(participant);
    notifyListeners();
  }

  updateType(ExpenseTemplateTypeEnum type) {
    _expenseTemplateState.tempData?.type = type;
    notifyListeners();
  }

  updateIntent(ExpenseTemplateIntentEnum type) {
    _expenseTemplateState.tempData?.intent = type;
    notifyListeners();
  }
}
