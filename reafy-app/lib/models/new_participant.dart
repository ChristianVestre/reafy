import 'package:flutter/widgets.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/new_expense_template.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/models/participants.dart';

class NewParticipant {
  String? participantName;
  String? companyName;
  String? newCompanyName;
  String? relation;

  NewParticipant(
      {this.participantName,
      this.newCompanyName,
      this.relation,
      this.companyName});
}
