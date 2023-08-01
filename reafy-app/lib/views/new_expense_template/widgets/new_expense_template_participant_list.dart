import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/provider/state_provider.dart';
import 'package:reafy/shared_widgets/new_expense_template_intent.dart';
import 'package:reafy/views/expense_view/expense_view.dart';
import 'package:reafy/views/new_expense_template/widgets/search.dart';
import 'package:reafy/views/new_expense_template/widgets/search_result_tile.dart';

import '../../../models/enums.dart';
import '../../../models/expense_template.dart';
import '../../../provider/data_provider.dart';
import '../../../provider/state_provider.dart';
import 'new_expense_template_list_tile.dart';

class NewExpenseTemplateParticipantList extends StatelessWidget {
  const NewExpenseTemplateParticipantList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseTemplateProvider>(
        builder: (context, expenseTemplateProvider, child) {
      return expenseTemplateProvider.isLoading
          ? const CircularProgressIndicator()
          : Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(children: [
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "Participants",
                      style: TextStyle(fontSize: 24),
                    ),
                    const Search(),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: expenseTemplateProvider
                            .expenseTemplateState.searchResult.length,
                        itemBuilder: ((context, index) => SearchResultTile(
                            participant: expenseTemplateProvider
                                .expenseTemplateState.searchResult[index])))
                  ])
                ]));
    });
  }
}
    
    
    
             /* NewExpenseObjectListTile(
                data: data,
                participant: data.participants.value[0],
                index: 0,
              ),
              const SizedBox(height: 10),
              ValueListenableBuilder(
                  valueListenable: data.participants,
                  builder: (context, value, _) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.participants.value.length - 1,
                        itemBuilder: ((context, index) =>
                            NewExpenseObjectListTile(
                              data: data,
                              participant: data.participants.value[index + 1],
                              deletable: true,
                              index: index,
                            )));
                  }),
              CupertinoButton(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.plus),
                      SizedBox(width: 10),
                      Text(
                        "Add participant",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  onPressed: () =>
                      {state.value = NewExpenseTemplateStateEnum.input}),
            ],
          ),
          Container(
              margin: const EdgeInsets.all(16),
              child: CupertinoButton.filled(
                  child: const Text("Finish"),
                  onPressed: () => {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => const ExpenseView(),
                          ),
                        )
                      }))*/
