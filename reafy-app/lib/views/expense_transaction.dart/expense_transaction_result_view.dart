import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/auth_provider.dart';
import 'package:reafy/provider/expense_provider.dart';
import 'package:reafy/shared_widgets/buttons/primary_button.dart';
import 'package:reafy/shared_widgets/reafy_appbar.dart';
import 'package:reafy/views/expense_transaction.dart/widgets/expense_transaction_rejected.dart';
import 'package:reafy/views/expense_transaction.dart/widgets/expense_transaction_success.dart';
import 'package:reafy/views/expense_view/expense_view.dart';

class ExpenseTransactionResultView extends StatelessWidget {
  const ExpenseTransactionResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ExpenseProvider, AuthProvider>(
        builder: (context, expenseProvider, authProvider, child) {
      return Scaffold(
        appBar: const ReafyAppBar(),
        body: expenseProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: expenseProvider.expenseTransaction.paymentRejected!
                    ? const ExpenseTransactionRejected()
                    : const ExpenseTransactionSuccess()),
        floatingActionButton: ReafyPrimaryButton(
            text: "Back",
            onPressed: () => {
                  //expenseProvider.getExpense(authProvider.reafyUser),
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ExpenseView())),
                }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    });
  }
}
