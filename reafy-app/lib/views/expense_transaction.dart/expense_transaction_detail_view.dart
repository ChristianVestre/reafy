import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/provider/auth_provider.dart';
import 'package:reafy/provider/expense_provider.dart';
import 'package:reafy/shared_widgets/reafy_appbar.dart';
import 'package:reafy/shared_widgets/reafy_nav_footer.dart';
import 'package:reafy/views/expense_transaction.dart/expense_transaction_result_view.dart';
import 'package:reafy/views/expense_transaction.dart/widgets/expense_detail_row.dart';
import 'package:reafy/views/expense_transaction.dart/widgets/expense_participants.dart';
import 'package:reafy/views/expense_transaction.dart/widgets/expense_transaction_line_items.dart';

class ExpenseTransactionDetailView extends StatelessWidget {
  const ExpenseTransactionDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ExpenseProvider, AuthProvider>(
      builder: (context, expenseProvider, authProvider, child) {
        return Scaffold(
          appBar: const ReafyAppBar(),
          body: SafeArea(
              child: Center(
                  child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              const SizedBox(height: 16),
              Text(
                "Transaction",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 32),
              ExpenseDetailRow(
                  leadingText: "Establishment",
                  trailingText:
                      expenseProvider.selectedExpense.establishmentName!),
              const ExpenseDetailRow(
                  leadingText: "Time", trailingText: "23:21, 1/9/2023"),
              const ExpenseTransactionLineItems(),
              ExpenseDetailRow(
                  leadingText: "Mva",
                  trailingText: expenseProvider.selectedExpense.mva.toString()),
              ExpenseDetailRow(
                  leadingText: "Total cost",
                  trailingText:
                      '${(expenseProvider.selectedExpense.totalExpense! / 100).round().toString()} kr'),
              const SizedBox(height: 32),
              ExpenseDetailRow(
                  leadingText: "Intent",
                  trailingText:
                      expenseProvider.selectedExpenseTemplate.intent!),
              ExpenseDetailRow(
                  leadingText: "Type",
                  trailingText: expenseProvider.selectedExpenseTemplate.type!),
              ExpenseDetailRow(
                  leadingText: "Number of participants",
                  trailingText: expenseProvider.selectedExpenseTemplate
                      .participants!.participants!.length
                      .toString()),
              const ExpenseParticipants()
            ]),
          ))),
          floatingActionButton: ReafyNavFooter(
            backOnPressed: () => Navigator.of(context).pop(),
            backText: "Back",
            forwardOnPressed: () => {
              expenseProvider.submitExpenseTransaction(authProvider.reafyUser),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ExpenseTransactionResultView()))
            },
            forwardText: "Complete",
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
