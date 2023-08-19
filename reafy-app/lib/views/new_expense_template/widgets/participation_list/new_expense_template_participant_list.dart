import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/shared_widgets/buttons/primary_button.dart';
import 'package:reafy/shared_widgets/reafy_nav_footer.dart';
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
                    const SizedBox(
                      height: 8,
                    ),
                    const FilterRow(),
                    const SizedBox(
                      height: 4,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: expenseTemplateProvider
                                .expenseTemplateState.searchResult.length,
                            itemBuilder: ((context, index) => SearchResultTile(
                                participant: expenseTemplateProvider
                                    .expenseTemplateState
                                    .searchResult[index]))))
                  ]),
                  ReafyNavFooter(
                    forwardText: "Next",
                    forwardOnPressed: () => {
                      expenseTemplateProvider.updateParticipants(
                          expenseTemplateProvider
                              .expenseTemplateState.searchResult),
                      expenseTemplateProvider
                          .updateStateStep(NewExpenseTemplateStateEnum.intent),
                    },
                    backText: "Cancel",
                    backOnPressed: () => Navigator.pop(context),
                  ),
                ]));
    });
  }
}
