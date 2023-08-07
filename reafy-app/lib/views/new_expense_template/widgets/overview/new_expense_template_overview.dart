import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/shared_widgets/buttons/reafy_text_button.dart';
import 'package:reafy/theme/colors.dart';
import 'package:reafy/views/new_expense_template/widgets/participation_list/search_result_tile.dart';

class NewExpenseTemplateOverview extends StatelessWidget {
  NewExpenseTemplateOverview({Key? key}) : super(key: key);

  List<Participant>? selectedParticipants;

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseTemplateProvider>(
        builder: (context, expenseTemplateProvider, child) {
      selectedParticipants = expenseTemplateProvider
          .expenseTemplateState.tempData?.participants
          ?.where((item) => item.selected == true)
          .toList();
      expenseTemplateProvider.expenseTemplateState.tempData?.participants
          ?.forEach((i) => print(i.participantName));
      expenseTemplateProvider.expenseTemplateState.searchResult
          .forEach((i) => print(i.participantName));

      return Container(
          margin: const EdgeInsets.all(16),
          child: Center(
              child: Column(
            children: [
              const SizedBox(height: 8),
              Column(
                children: [
                  Text(
                    "Expense Template",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.5, color: Theme.of(context).borderColor),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Intent",
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              ReafyTextButton(
                                text: "edit",
                                color: Theme.of(context).primaryColor,
                                onPressed: () =>
                                    expenseTemplateProvider.updateStateStep(
                                        NewExpenseTemplateStateEnum.intent),
                              )
                            ],
                          ),
                          Text(
                            expenseTemplateProvider.expenseTemplateState
                                .tempData!.intent!.stringValues,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Text(
                                "Type",
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              ReafyTextButton(
                                text: "edit",
                                color: Theme.of(context).primaryColor,
                                onPressed: () =>
                                    expenseTemplateProvider.updateStateStep(
                                        NewExpenseTemplateStateEnum.type),
                              )
                            ],
                          ),
                          Text(
                            expenseTemplateProvider.expenseTemplateState
                                .tempData!.type!.stringValues,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              Text(
                                "Participants",
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              ReafyTextButton(
                                  text: "edit",
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () =>
                                      expenseTemplateProvider.updateStateStep(
                                          NewExpenseTemplateStateEnum.list))
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: selectedParticipants?.length,
                              itemBuilder: ((context, index) =>
                                  SearchResultTile(
                                    participant: selectedParticipants![index],
                                    selectable: false,
                                  ))),
                        ],
                      ))
                ],
              )
            ],
          )));
    });
  }
}
