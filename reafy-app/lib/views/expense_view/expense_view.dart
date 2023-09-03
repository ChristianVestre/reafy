import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/auth_provider.dart';
import 'package:reafy/provider/expense_provider.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/shared_widgets/buttons/reafy_text_button.dart';
import 'package:reafy/shared_widgets/reafy_appbar.dart';
import 'package:reafy/views/expense_view/widgets/expense_detail.dart';
import 'package:reafy/views/expense_view/widgets/no_expense.dart';
import 'package:reafy/views/new_expense_template/new_expense_template_view.dart';

final bool expense = true;

class ExpenseView extends StatefulWidget {
  const ExpenseView({
    Key? key,
  }) : super(key: key);

  @override
  State<ExpenseView> createState() => _ExpenseView();
}

class _ExpenseView extends State<ExpenseView> {
  @override
  void initState() {
    super.initState();
    final expenseProvider =
        Provider.of<ExpenseProvider>(context, listen: false);
    expenseProvider.getExpense();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ReafyAppBar(),
        body: SafeArea(child: Consumer<ExpenseProvider>(
            builder: (context, expenseProvider, child) {
          return expenseProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      expenseProvider.expense.expenseId != null
                          ? const ExpenseDetail()
                          : const NoExpense(),
                      ReafyTextButton(
                          plusIcon: true,
                          onPressed: () => {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProxyProvider<
                                              AuthProvider,
                                              ExpenseTemplateProvider>(
                                            create: (BuildContext context) =>
                                                ExpenseTemplateProvider(
                                                    Provider.of<AuthProvider>(
                                                        context,
                                                        listen: false)),
                                            update: (BuildContext context,
                                                    AuthProvider authProvider,
                                                    ExpenseTemplateProvider?
                                                        expenseTemplateProvider) =>
                                                ExpenseTemplateProvider(
                                                    authProvider),
                                            child:
                                                const NewExpenseTemplateView(),
                                          )),
                                )
                              },
                          text: "Prepare for new expense")
                    ]));
        })));
  }
}
