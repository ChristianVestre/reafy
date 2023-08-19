import 'package:flutter/material.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/expense_template.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/shared_widgets/reafy_appbar.dart';
import 'package:reafy/views/select_expense_template/widgets/select_expense_template_card.dart';

final List<NewExpenseTemplateData> expenseTemplates = [
  NewExpenseTemplateData(
      type: NewExpenseTemplateTypeEnum.velferd,
      intent: NewExpenseTemplateIntentEnum.meeting,
      participants: [
        Participant(participantName: "Timo Rapp", companyName: "ScaleupXQ"),
        Participant(
            participantName: "Lars Johan Bjørkvoll", companyName: "ScaleupXQ"),
        Participant(participantName: "Christian Vestre", companyName: "Tyve"),
        Participant(participantName: "Jørn Haukøy", companyName: "Code11"),
      ]),
  NewExpenseTemplateData(
      type: NewExpenseTemplateTypeEnum.velferd,
      intent: NewExpenseTemplateIntentEnum.meeting,
      participants: [
        Participant(participantName: "Timo Rapp", companyName: "ScaleupXQ"),
        Participant(
            participantName: "Lars Johan Bjørkvoll", companyName: "ScaleupXQ"),
        Participant(participantName: "Christian Vestre", companyName: "Tyve"),
        Participant(participantName: "Jørn Haukøy", companyName: "Code11"),
      ]),
];

class SelectExpenseTemplate extends StatelessWidget {
  const SelectExpenseTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ReafyAppBar(),
        body: SafeArea(
            child: Center(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                "Choose expense template",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: expenseTemplates.length,
                  itemBuilder: ((context, index) => SelectExpenseTemplateCard(
                      expenseTemplate: expenseTemplates[index])))
            ],
          ),
        )));
  }
}
