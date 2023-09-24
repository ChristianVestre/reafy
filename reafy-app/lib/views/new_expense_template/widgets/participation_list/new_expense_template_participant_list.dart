import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/shared_widgets/buttons/reafy_text_button.dart';
import 'package:reafy/shared_widgets/reafy_nav_footer.dart';
import 'package:reafy/views/new_expense_template/widgets/participation_list/add_participant.dart';
import 'package:reafy/views/new_expense_template/widgets/participation_list/filter_row.dart';
import 'package:reafy/views/new_expense_template/widgets/participation_list/search.dart';
import 'package:reafy/views/new_expense_template/widgets/participation_list/search_result_tile.dart';

class NewExpenseTemplateParticipantList extends StatelessWidget {
  const NewExpenseTemplateParticipantList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseTemplateProvider>(
        builder: (context, expenseTemplateProvider, child) {
      return expenseTemplateProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ))
          : Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Participants",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Search(),
                    const FilterRow(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SearchResultTile(
                          participant: expenseTemplateProvider.userParticipant,
                          selectable: false),
                    ),
                    Divider(
                      height: 8,
                      thickness: 1,
                      indent: 16,
                      endIndent: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height / 2.35,
                            child: ListView.builder(
                                itemCount: expenseTemplateProvider
                                    .expenseTemplateState
                                    .searchResult!
                                    .participants!
                                    .length,
                                itemBuilder: ((context, index) =>
                                    SearchResultTile(
                                        participant: expenseTemplateProvider
                                            .expenseTemplateState
                                            .searchResult!
                                            .participants![index])))))
                  ]),
                  Column(
                    children: [
                      ReafyTextButton(
                          plusIcon: true,
                          text: "Add new participant",
                          onPressed: () => {
                                expenseTemplateProvider.updateStateStep(
                                    NewExpenseTemplateStateEnum.participant),
                              }),
                      const SizedBox(
                        height: 8,
                      ),
                      ReafyNavFooter(
                        forwardText: "Next",
                        forwardOnPressed: () => {
                          if (expenseTemplateProvider
                              .expenseTemplateState.searchResult!.participants!
                              .where((item) => item.selected == true)
                              .toList()
                              .isEmpty)
                            {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Center(
                                child: Text(
                                    'Please make sure you have selected a participant.'),
                              )))
                            }
                          else
                            {
                              expenseTemplateProvider.updateParticipants(
                                  expenseTemplateProvider
                                      .expenseTemplateState.searchResult!),
                              expenseTemplateProvider.updateStateStep(
                                  NewExpenseTemplateStateEnum.overview),
                            }
                        },
                        backText: "Back",
                        backOnPressed: () =>
                            expenseTemplateProvider.updateStateStep(
                                NewExpenseTemplateStateEnum.intent),
                      ),
                    ],
                  )
                ]));
    });
  }
}
