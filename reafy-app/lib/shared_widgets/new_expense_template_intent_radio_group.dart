import 'package:flutter/material.dart';
import 'package:reafy/views/new_expense_template_view.dart';
import 'package:flutter/cupertino.dart';

import '../models/enums.dart';
import '../models/expense_template.dart';

class NewExpenseObjectIntentRadioGroup extends StatelessWidget {
  const NewExpenseObjectIntentRadioGroup({Key? key, required this.data})
      : super(key: key);

  final NewExpenseTemplateData data;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(children: [
              Transform.scale(
                  scale: 1.2,
                  child: CupertinoRadio(
                      activeColor: const Color(0xFFD499B9),
                      value: NewExpenseTemplateTypeEnum
                          .ikkeFradragsberettigetRepresentasjon,
                      groupValue: data.type.value,
                      onChanged: (NewExpenseTemplateTypeEnum? value) =>
                          {data.type.value = value!})),
              const SizedBox(width: 8),
              const Text("Ikke fradragsberettiget representasjon",
                  style: TextStyle(fontSize: 20)),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              Transform.scale(
                  scale: 1.2,
                  child: CupertinoRadio(
                      activeColor: const Color(0xFFD499B9),
                      value: NewExpenseTemplateTypeEnum
                          .fradragsberettigetRepresentasjon,
                      groupValue: data.type.value,
                      onChanged: (NewExpenseTemplateTypeEnum? value) =>
                          {data.type.value = value!})),
              const SizedBox(width: 8),
              const Text("Fradragsberettiget representasjon",
                  style: TextStyle(fontSize: 20)),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              Transform.scale(
                  scale: 1.2,
                  child: CupertinoRadio(
                      activeColor: const Color(0xFFD499B9),
                      value: NewExpenseTemplateTypeEnum.velferd,
                      groupValue: data.type.value,
                      onChanged: (NewExpenseTemplateTypeEnum? value) =>
                          {data.type.value = value!})),
              const SizedBox(width: 8),
              const Text("Velferd", style: TextStyle(fontSize: 20)),
            ]),
          ],
        ));
  }
}
