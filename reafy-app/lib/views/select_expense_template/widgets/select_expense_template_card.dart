import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/expense_template.dart';
import 'package:reafy/models/new_expense_template.dart';
import 'package:reafy/theme/colors.dart';

class SelectExpenseTemplateCard extends StatelessWidget {
  const SelectExpenseTemplateCard({Key? key, required this.expenseTemplate})
      : super(key: key);

  final NewExpenseTemplateData expenseTemplate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).borderColor),
          borderRadius: BorderRadius.circular(5)),
      child: Column(children: [
        Row(
          children: [
            Text(
              "Intent",
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                  color: Theme.of(context).primaryColor),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(expenseTemplate.intent!.stringValues)
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Text("Type",
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                    color: Theme.of(context).primaryColor)),
            const SizedBox(
              width: 8,
            ),
            Text(expenseTemplate.type!.stringValues)
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Text("Participants",
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                    color: Theme.of(context).primaryColor)),
            const SizedBox(
              width: 8,
            ),
            Flexible(
                child: Text(
              expenseTemplate.participants!.participants!
                  .map((item) => item.participantName)
                  .toString(),
            ))
          ],
        ),
      ]),
    );
  }
}
