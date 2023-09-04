import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/expense_provider.dart';
import 'package:reafy/views/expense_transaction.dart/widgets/expense_detail_row.dart';
import 'package:reafy/views/expense_view/widgets/expense_line_item.dart';

class ExpenseTransactionLineItems extends StatelessWidget {
  const ExpenseTransactionLineItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
        builder: (context, expenseProvider, child) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: const Text("Items purchased:"),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 0, 8),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: expenseProvider.expense.lineItems!.length,
                  itemBuilder: ((context, index) => ExpenseDetailRow(
                      leadingText:
                          expenseProvider.expense.lineItems![index].name!,
                      trailingText:
                          '${expenseProvider.expense.lineItems![index].numberPurchased!} x ${(expenseProvider.expense.lineItems![index].costPerItem! / 10).round().toString()} kr'))))
        ]),
      );
    });
  }
}
