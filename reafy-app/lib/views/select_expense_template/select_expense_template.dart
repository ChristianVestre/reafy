import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/new_expense_template.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/models/participants.dart';
import 'package:reafy/provider/expense_provider.dart';
import 'package:reafy/shared_widgets/buttons/secondary_button.dart';
import 'package:reafy/shared_widgets/reafy_appbar.dart';
import 'package:reafy/views/select_expense_template/widgets/select_expense_template_card.dart';

final List<NewExpenseTemplateData> expenseTemplates = [
  NewExpenseTemplateData(
      type: ExpenseTemplateTypeEnum.velferd,
      intent: ExpenseTemplateIntentEnum.meeting,
      participants: Participants(participants: [
        Participant(participantName: "Timo Rapp", companyName: "ScaleupXQ"),
        Participant(
            participantName: "Lars Johan Bjørkvoll", companyName: "ScaleupXQ"),
        Participant(participantName: "Christian Vestre", companyName: "Tyve"),
        Participant(participantName: "Jørn Haukøy", companyName: "Code11"),
      ])),
  NewExpenseTemplateData(
      type: ExpenseTemplateTypeEnum.velferd,
      intent: ExpenseTemplateIntentEnum.meeting,
      participants: Participants(participants: [
        Participant(participantName: "Timo Rapp", companyName: "ScaleupXQ"),
        Participant(
            participantName: "Lars Johan Bjørkvoll", companyName: "ScaleupXQ"),
        Participant(participantName: "Christian Vestre", companyName: "Tyve"),
        Participant(participantName: "Jørn Haukøy", companyName: "Code11"),
      ])),
];

class SelectExpenseTemplateView extends StatefulWidget {
  const SelectExpenseTemplateView({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectExpenseTemplateView> createState() =>
      _SelectExpenseTemplateView();
}

class _SelectExpenseTemplateView extends State<SelectExpenseTemplateView> {
  @override
  /* void initState() {
    super.initState();
    final expenseProvider =
        Provider.of<ExpenseProvider>(context, listen: false);
    expenseProvider.getExpenseTemplates();
  }*/

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
                      expenseTemplate: expenseTemplates[index]))),
              ReafySecondaryButton(
                  text: "Back", onPressed: () => {Navigator.pop(context)})
            ],
          ),
        )));
  }
}
