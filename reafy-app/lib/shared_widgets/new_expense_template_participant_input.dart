import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/enums.dart';
import '../models/expense_template.dart';
import '../models/participant.dart';
import '../views/new_expense_template/new_expense_template_view.dart';

class NewExpenseObjectParticipantInput extends StatelessWidget {
  NewExpenseObjectParticipantInput(
      {Key? key, required this.data, required this.state})
      : super(key: key);

  final NewExpenseTemplateData data;
  final ValueNotifier<NewExpenseTemplateStateEnum> state;
  final _nameEditingController = TextEditingController();
  final _companyEditingController = TextEditingController();
  final _participantFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Add participant", style: TextStyle(fontSize: 24)),
        const SizedBox(
          height: 40,
        ),
        Expanded(
            child: Form(
                key: _participantFormKey,
                child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Name of participant"),
                          CupertinoTextFormFieldRow(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please write a name';
                                }
                                return null;
                              },
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 0),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(5)),
                              controller: _nameEditingController,
                              placeholder: "Name"),
                          const SizedBox(height: 20),
                          const Text("Company of participant"),
                          CupertinoTextFormFieldRow(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 0),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(5)),
                              controller: _companyEditingController,
                              placeholder: "Company")
                        ])))),
        Container(
            margin: const EdgeInsets.all(16),
            child: CupertinoButton.filled(
                child: const Text("Done"),
                onPressed: () => {
                      if (_participantFormKey.currentState!.validate())
                        {
                          /*     state.value = NewExpenseTemplateStateEnum.list,
                          data.participants.value.add(Participant(
                              name: _nameEditingController.text,
                              company: _companyEditingController.text)) */
                        }
                    }))
      ],
    );
  }
}
