import 'dart:convert';
import 'dart:developer';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reafy/helpers/constants.dart';
import 'package:reafy/models/expense_template.dart';
import 'package:reafy/models/expense_templates.dart';
import 'package:reafy/models/user.dart';
import 'package:reafy/provider/auth_provider.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  Expense expense = Expense();
  ExpenseTemplates expenseTemplates = ExpenseTemplates();
  ExpenseTemplate selectedExpenseTemplate = ExpenseTemplate();
  bool isLoading = false;

  Future<bool> getExpense(ReafyUser user) async {
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
        expense = Expense.fromJson(expenseInfoJson);
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

  Future<bool> submitExpenseTransaction(ReafyUser user) async {
    final Map body = {
      "establishmentId": expense.establishmentId,
      "settledById": user.userId,
      "expenseId": expense.expenseId,
      "expenseTemplateId": selectedExpenseTemplate.expenseTemplateId,
      "companyId": user.companyId
    };
    final encodedBody = json.encode(body);

    try {
      isLoading = true;
      final expenseResponse = await http.post(
          Uri.parse('$baseApiUrl/expense/expense-transaction'),
          body: encodedBody,
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

  updateSelectedExpenseTemplate(ExpenseTemplate expenseTemplate) {
    selectedExpenseTemplate = expenseTemplate;
    notifyListeners();
  }
}
