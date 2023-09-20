import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/provider/auth_provider.dart';
import 'package:reafy/provider/expense_provider.dart';
import 'package:reafy/shared_widgets/reafy_appbar.dart';
import 'package:reafy/shared_widgets/reafy_nav_footer.dart';
import 'package:reafy/views/expense_transaction.dart/widgets/expense_detail_row.dart';
import 'package:reafy/views/expense_transaction.dart/widgets/expense_participants.dart';
import 'package:reafy/views/expense_transaction.dart/widgets/expense_transaction_line_items.dart';

class ExpenseTransactionRejected extends StatelessWidget {
  const ExpenseTransactionRejected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ExpenseProvider, AuthProvider>(
      builder: (context, expenseProvider, authProvider, child) {
        return Center(
            child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            const SizedBox(height: 16),
            Text(
              "Transaction rejected",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              itemCount:
                  expenseProvider.expenseTransaction.rejectionReason!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => Text(
                  '- ${expenseProvider.expenseTransaction.rejectionReason![index]}'),
            )
          ]),
        ));
      },
    );
  }
}
