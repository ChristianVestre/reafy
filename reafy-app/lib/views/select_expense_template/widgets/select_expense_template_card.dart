import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/expense_template.dart';
import 'package:reafy/provider/expense_provider.dart';
import 'package:reafy/theme/colors.dart';
import 'package:reafy/views/expense_transaction.dart/expense_transaction_detail_view.dart';

class SelectExpenseTemplateCard extends StatelessWidget {
  const SelectExpenseTemplateCard({Key? key, required this.expenseTemplate})
      : super(key: key);

  final ExpenseTemplate expenseTemplate;

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
        builder: (context, expenseProvider, child) {
      return GestureDetector(
          onTap: () => {
                expenseProvider.updateSelectedExpenseTemplate(expenseTemplate),
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const ExpenseTransactionDetailView())),
              },
          child: Container(
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
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize,
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
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium!.fontSize,
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
                  Text("# of participants",
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium!.fontSize,
                          color: Theme.of(context).primaryColor)),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(expenseTemplate.participants!.participants!.length
                      .toString())
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Participants",
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium!.fontSize,
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
          ));
    });
  }
}
