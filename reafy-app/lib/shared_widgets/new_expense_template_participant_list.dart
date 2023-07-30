import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reafy/shared_widgets/new_expense_template_intent.dart';
import 'package:reafy/views/expense_view/expense_view.dart';

import '../models/enums.dart';
import '../models/expense_template.dart';
import 'new_expense_template_list_tile.dart';

class NewExpenseObjectParticipantList extends StatelessWidget {
  const NewExpenseObjectParticipantList(
      {Key? key, required this.data, required this.state})
      : super(key: key);

  final NewExpenseTemplateData data;
  final ValueNotifier<NewExpenseTemplateStateEnum> state;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Column(
            children: [
              const Text(
                "Participants",
                style: TextStyle(fontSize: 24),
              ),
              const Text("Mesh Youngstorget 31.05.23"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Intent: "),
                  CupertinoButton(
                      child: Text(data.intent ?? ""),
                      onPressed: () => {
                            state.value = NewExpenseTemplateStateEnum.intent,
                            data.intent = intentItems.contains(data.intent)
                                ? data.intent
                                : data.intent = "Other"
                          }),
                ],
              ),
              NewExpenseObjectListTile(
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
                      }))
        ]));
  }
}
