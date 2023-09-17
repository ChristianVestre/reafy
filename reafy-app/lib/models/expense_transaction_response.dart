import 'package:flutter/widgets.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/new_expense_template.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/models/participants.dart';

class ExpenseTransactionResponse {
  bool? paymentRejected;
  String? rejectionReason;

  ExpenseTransactionResponse({this.paymentRejected, this.rejectionReason});

  ExpenseTransactionResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    paymentRejected = json['paymentRejected'];
    rejectionReason = json['rejectionReason'];
  }
}
