import 'dart:convert';
import 'dart:developer';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reafy/helpers/constants.dart';
import 'package:reafy/models/expense_check.dart';
import 'package:reafy/models/expense_transaction_response.dart';
import 'package:reafy/models/expense_template.dart';
import 'package:reafy/models/expense_templates.dart';
import 'package:reafy/models/user.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> expenses = [];
  ExpenseTemplates expenseTemplates = ExpenseTemplates();
  Expense selectedExpense = Expense();
  ExpenseTemplate selectedExpenseTemplate = ExpenseTemplate();
  ExpenseTransactionResponse expenseTransaction = ExpenseTransactionResponse();
  ExpenseCheck expenseCheck = ExpenseCheck();
  bool isLoading = false;

  Future<bool> getExpense(ReafyUser user) async {
    expenses = [];
    try {
      isLoading = true;
      final expenseResponse = await http.get(
          Uri.parse('$baseApiUrl/expense/expense?id=${user.userId}'),
          headers: {
            "authorization":
                'Bearer ${JWT({}).sign(key, algorithm: JWTAlgorithm.HS256)}'
          });

      if (expenseResponse.statusCode == 200) {
        final expenseInfoJson = json.decode(expenseResponse.body);
        expenseInfoJson
            .forEach((infoJson) => expenses.add(Expense.fromJson(infoJson)));
      }

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> getExpenseTemplates(ReafyUser user) async {
    try {
      isLoading = true;
      final expenseResponse = await http.get(
          Uri.parse('$baseApiUrl/expense/expense-template?id=${user.userId}'),
          headers: {
            "authorization":
                'Bearer ${JWT({}).sign(key, algorithm: JWTAlgorithm.HS256)}'
          });

      if (expenseResponse.statusCode == 200) {
        final expenseInfoJson = json.decode(expenseResponse.body);
        expenseTemplates = ExpenseTemplates.fromJson(expenseInfoJson);
      }
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  updateSelectedExepense(Expense expense) {
    selectedExpense = expense;
    notifyListeners();
  }

  Future<bool> submitExpenseTransaction(ReafyUser user) async {
    final Map body = {
      "establishmentId": selectedExpense.establishmentId,
      "settledById": user.userId,
      "expenseId": selectedExpense.expenseId,
      "expenseTemplateId": selectedExpenseTemplate.expenseTemplateId,
      "companyId": user.companyId,
      "role": user.role
    };
    final encodedBody = json.encode(body);

    try {
      isLoading = true;
      final expenseTransactionResponse = await http.post(
          Uri.parse('$baseApiUrl/expense/expense-transaction'),
          body: encodedBody,
          headers: {
            "authorization":
                'Bearer ${JWT({}).sign(key, algorithm: JWTAlgorithm.HS256)}'
          });

      if (expenseTransactionResponse.statusCode == 200) {
        final expenseTransactionJson =
            json.decode(expenseTransactionResponse.body);
        expenseTransaction =
            ExpenseTransactionResponse.fromJson(expenseTransactionJson);
      }
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> submitExpenseCheck() async {
    final Map body = {
      "expenseId": selectedExpense.expenseId,
      "expenseTemplateId": selectedExpenseTemplate.expenseTemplateId
    };
    final encodedBody = json.encode(body);

    try {
      isLoading = true;
      final expenseCheckResponse = await http.post(
          Uri.parse('$baseApiUrl/expense/expense-check'),
          body: encodedBody,
          headers: {
            "authorization":
                'Bearer ${JWT({}).sign(key, algorithm: JWTAlgorithm.HS256)}'
          });

      if (expenseCheckResponse.statusCode == 200) {
        final expenseCheckJson = json.decode(expenseCheckResponse.body);
        expenseCheck = ExpenseCheck.fromJson(expenseCheckJson);
      }
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  updateSelectedExpenseTemplate(ExpenseTemplate expenseTemplate) {
    selectedExpenseTemplate = expenseTemplate;
    notifyListeners();
  }
}
