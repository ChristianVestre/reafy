import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/expense.dart';
import 'package:reafy/provider/expense_provider.dart';

class ExpenseMetaInfo extends StatelessWidget {
  const ExpenseMetaInfo({Key? key, required this.expense}) : super(key: key);

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
        builder: (context, expenseProvider, child) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Mva",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge!.fontSize,
                        fontWeight: FontWeight.w600)),
                Text(
                  expense.mva != null ? (expense.mva! / 100).toString() : "",
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total cost",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge!.fontSize,
                        fontWeight: FontWeight.w600)),
                Text(
                  expense.totalExpense != null
                      ? (expense.totalExpense! / 100).toString()
                      : "",
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            )
          ]));
    });
  }
}
