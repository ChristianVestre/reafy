import 'package:flutter/material.dart';
import 'package:reafy/views/new_expense_object_view.dart';
import 'package:flutter/cupertino.dart';

class NewExpenseObjectIntentRadioGroup extends StatelessWidget {
  const NewExpenseObjectIntentRadioGroup({Key? key, required this.data})
      : super(key: key);

  final NewExpenseObjectData data;

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
                      value: NewExpenseObjectTypeEnum
                          .ikkeFradragsberettigetRepresentasjon,
                      groupValue: data.type.value,
                      onChanged: (NewExpenseObjectTypeEnum? value) =>
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
                      value: NewExpenseObjectTypeEnum
                          .fradragsberettigetRepresentasjon,
                      groupValue: data.type.value,
                      onChanged: (NewExpenseObjectTypeEnum? value) =>
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
                      value: NewExpenseObjectTypeEnum.velferd,
                      groupValue: data.type.value,
                      onChanged: (NewExpenseObjectTypeEnum? value) =>
                          {data.type.value = value!})),
              const SizedBox(width: 8),
              const Text("Velferd", style: TextStyle(fontSize: 20)),
            ]),
          ],
        ));
  }
}
