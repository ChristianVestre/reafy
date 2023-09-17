import 'package:flutter/material.dart';
import 'package:reafy/shared_widgets/buttons/primary_button.dart';
import 'package:reafy/shared_widgets/reafy_appbar.dart';
import 'package:reafy/views/expense_view/expense_view.dart';

class ExpenseTransactionSuccess extends StatelessWidget {
  const ExpenseTransactionSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: const EdgeInsets.only(bottom: 80),
            child: Text(
              "Transaction complete!",
              style: Theme.of(context).textTheme.titleMedium,
            )));
  }
}
