import 'package:flutter/widgets.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/new_expense_template.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/models/participants.dart';

class ExpenseTransactionResponse {
  bool? paymentRejected;
  List<String>? rejectionReason;

  ExpenseTransactionResponse({this.paymentRejected, this.rejectionReason});

  ExpenseTransactionResponse.fromJson(Map<String, dynamic> json) {
    paymentRejected = json['paymentRejected'];
    rejectionReason = [];
    if (json['rejectionReason'].length != 0) {
      json['rejectionReason'].forEach((v) {
        rejectionReason!.add(v);
      });
    }
  }
}
