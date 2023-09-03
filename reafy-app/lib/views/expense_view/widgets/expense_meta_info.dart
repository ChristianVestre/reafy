import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/expense_provider.dart';

class ExpenseMetaInfo extends StatelessWidget {
  const ExpenseMetaInfo({Key? key}) : super(key: key);

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
                  expenseProvider.expense.mva != null
                      ? expenseProvider.expense.mva.toString()
                      : "",
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
                  expenseProvider.expense.totalExpense != null
                      ? expenseProvider.expense.totalExpense.toString()
                      : "",
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            )
          ]));
    });
  }
}
