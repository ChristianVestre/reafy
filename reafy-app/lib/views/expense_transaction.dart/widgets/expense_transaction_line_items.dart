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
              child: SizedBox(
                  height: MediaQuery.sizeOf(context).height / 7.5,
                  child: ListView.builder(
                      itemCount:
                          expenseProvider.selectedExpense.lineItems!.length,
                      itemBuilder: ((context, index) => ExpenseDetailRow(
                          leadingText: expenseProvider
                              .selectedExpense.lineItems![index].name!,
                          trailingText:
                              '${expenseProvider.selectedExpense.lineItems![index].numberPurchased!} x ${(expenseProvider.selectedExpense.lineItems![index].costPerItem! / 100).round().toString()} kr')))))
        ]),
      );
    });
  }
}
