import 'package:flutter/material.dart';
import 'package:reafy/shared_widgets/buttons/primary_button.dart';
import 'package:reafy/shared_widgets/reafy_appbar.dart';
import 'package:reafy/views/expense_view/expense_view.dart';

class ExpenseTransactionSuccessView extends StatefulWidget {
  const ExpenseTransactionSuccessView({Key? key}) : super(key: key);

  @override
  _ExpenseTransactionSuccessViewState createState() =>
      _ExpenseTransactionSuccessViewState();
}

class _ExpenseTransactionSuccessViewState
    extends State<ExpenseTransactionSuccessView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReafyAppBar(),
      body: Center(
        child: Text(
          "Transaction complete!",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      floatingActionButton: ReafyPrimaryButton(
        text: "Back",
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const ExpenseView())),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
