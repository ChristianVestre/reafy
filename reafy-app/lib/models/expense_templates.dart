import 'package:reafy/models/expense_template.dart';

class ExpenseTemplates {
  List<ExpenseTemplate>? templates;

  ExpenseTemplates({this.templates});

  ExpenseTemplates.fromJson(List<dynamic> json) {
    templates = <ExpenseTemplate>[];
    json.forEach((v) {
      templates!.add(ExpenseTemplate.fromJson(v));
    });
  }
}
