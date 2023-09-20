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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final expenseProvider =
        Provider.of<ExpenseProvider>(context, listen: false);
    expenseProvider.getExpense(authProvider.reafyUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReafyAppBar(),
      body: SafeArea(child:
          Consumer<ExpenseProvider>(builder: (context, expenseProvider, child) {
        return expenseProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : expenseProvider.expenses.isEmpty
                ? const Center(child: NoExpense())
                : Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Container(
                            margin: const EdgeInsets.only(top: 32),
                            child: Text(
                              "New Expense",
                              style: Theme.of(context).textTheme.titleMedium,
                            )),
                        Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: expenseProvider.expenses.length,
                                itemBuilder: ((context, index) => ExpenseDetail(
                                      expense: expenseProvider.expenses[index],
                                    )))),
                      ]));
      })),
      floatingActionButton: ReafyTextButton(
          plusIcon: true,
          onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ChangeNotifierProxyProvider<
                              AuthProvider, ExpenseTemplateProvider>(
                            create: (BuildContext context) =>
                                ExpenseTemplateProvider(
                                    Provider.of<AuthProvider>(context,
                                        listen: false)),
                            update: (BuildContext context,
                                    AuthProvider authProvider,
                                    ExpenseTemplateProvider?
                                        expenseTemplateProvider) =>
                                ExpenseTemplateProvider(authProvider),
                            child: const NewExpenseTemplateView(),
                          )),
                )
              },
          text: "Prepare for new expense"),
    );
  }
}
