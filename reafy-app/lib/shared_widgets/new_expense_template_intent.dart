import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reafy/shared_widgets/new_expense_template_intent_picker.dart';
import 'package:reafy/shared_widgets/new_expense_template_intent_radio_group.dart';

import '../models/enums.dart';
import '../models/expense_template.dart';
import '../views/new_expense_template_view.dart';

const List<String> intentItems = <String>[
  'Møteservering',
  'Kundepleie',
  'Rekrutering',
  'Partnerpleie',
  'Other'
];

int selectedIntentItemHelper(NewExpenseTemplateData data) {
  if (intentItems.contains(data.intent)) {
    return intentItems.indexOf(data.intent!);
  } else {
    return 0;
  }
}

//ignore: must_be_immutable
class NewExpenseObjectIntent extends StatelessWidget {
  NewExpenseObjectIntent({Key? key, required this.data, required this.state})
      : super(key: key);

  final NewExpenseTemplateData data;
  final ValueNotifier<NewExpenseTemplateStateEnum> state;
  final _textEditingController = TextEditingController();
  ValueNotifier<int> selectedItemState = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(children: [
          NewExpenseTemplateIntentPicker(
              data: data,
              selectedIntentItem: selectedItemState =
                  ValueNotifier(selectedIntentItemHelper(data)),
              intentItems: intentItems),
          ValueListenableBuilder(
              valueListenable: selectedItemState,
              builder: (context, value, _) {
                return Visibility(
                    visible: value ==
                        4, //need to match the index of "Other" in the intentItems list
                    child: CupertinoTextFormFieldRow(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5)),
                        controller: _textEditingController,
                        onEditingComplete: () =>
                            {data.intent = _textEditingController.text},
                        placeholder: "Write intent"));
              }),
          const SizedBox(
            height: 60,
          ),
          const Text(
            "Expense type",
            style: TextStyle(fontSize: 24),
          ),
          ValueListenableBuilder(
              valueListenable: data.type,
              builder: (context, value, _) {
                return NewExpenseObjectIntentRadioGroup(data: data);
              })
        ]),
        Container(
          margin: const EdgeInsets.all(16),
          child: CupertinoButton.filled(
              child: const Text("Done"),
              onPressed: () =>
                  {state.value = NewExpenseTemplateStateEnum.list}),
        )
      ],
    );
  }
}
