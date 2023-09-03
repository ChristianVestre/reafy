import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/provider/auth_provider.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/shared_widgets/buttons/primary_button.dart';
import 'package:reafy/shared_widgets/buttons/reafy_text_button.dart';
import 'package:reafy/shared_widgets/reafy_nav_footer.dart';
import 'package:reafy/theme/colors.dart';
import 'package:reafy/views/new_expense_template/widgets/participation_list/search_result_tile.dart';

class NewExpenseTemplateOverview extends StatelessWidget {
  NewExpenseTemplateOverview({Key? key}) : super(key: key);

  List<Participant>? selectedParticipants;

  @override
  Widget build(BuildContext context) {
    return Consumer2<ExpenseTemplateProvider, AuthProvider>(
        builder: (context, expenseTemplateProvider, authProvider, child) {
      selectedParticipants = expenseTemplateProvider
          .expenseTemplateState.tempData?.participants!.participants
          ?.where((item) => item.selected == true)
          .toList();

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Text(
                "Expense Template",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.5, color: Theme.of(context).borderColor),
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Intent",
                            style: Theme.of(context).textTheme.headlineLarge,
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
                        expenseTemplateProvider.expenseTemplateState.tempData!
                            .intent!.stringValues,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            "Type",
                            style: Theme.of(context).textTheme.headlineLarge,
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
                        expenseTemplateProvider
                            .expenseTemplateState.tempData!.type!.stringValues,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Text(
                            "Participants",
                            style: Theme.of(context).textTheme.headlineLarge,
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
                          itemBuilder: ((context, index) => SearchResultTile(
                                participant: selectedParticipants![index],
                                selectable: false,
                              ))),
                    ],
                  ))
            ],
          ),
          ReafyNavFooter(
              backText: "Back",
              forwardText: "Save",
              backOnPressed: () => expenseTemplateProvider
                  .updateStateStep(NewExpenseTemplateStateEnum.list),
              forwardOnPressed: () => {
                    expenseTemplateProvider
                        .submitExpenseTemplate(authProvider.reafyUser.userId!),
                    Navigator.pop(context)
                  })
        ],
      );
    });
  }
}
