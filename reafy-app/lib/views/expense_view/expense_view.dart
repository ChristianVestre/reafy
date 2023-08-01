import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/shared_widgets/buttons/reafy_text_button.dart';
import 'package:reafy/shared_widgets/reafy_appbar.dart';
import 'package:reafy/views/expense_view/widgets/expense_detail.dart';
import 'package:reafy/views/expense_view/widgets/no_expense.dart';
import 'package:reafy/views/new_expense_template/new_expense_template_view.dart';

final bool expense = false;

class ExpenseView extends StatelessWidget {
  const ExpenseView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ReafyAppBar(),
        body: SafeArea(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
              expense ? const ExpenseDetail() : const NoExpense(),
              ReafyTextButton(
                  plusIcon: true,
                  onPressed: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider<
                                      ExpenseTemplateProvider>(
                                    create: (_) => ExpenseTemplateProvider(),
                                    child: const NewExpenseTemplateView(),
                                  )),
                        )
                      },
                  text: "Prepare for new expense")
            ]))));
  }
}
