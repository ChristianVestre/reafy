import 'package:flutter/widgets.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/new_expense_template.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/models/participants.dart';

class NewParticipant {
  TextEditingController? nameController = TextEditingController();
  String? companyName;
  TextEditingController? newCompanyController = TextEditingController();
  TextEditingController? relationController = TextEditingController();

  NewParticipant(
      {this.nameController,
      this.newCompanyController,
      this.relationController,
      this.companyName});
}
