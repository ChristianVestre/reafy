import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/models/new_expense_template.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/models/participants.dart';
import 'package:reafy/provider/auth_provider.dart';
import 'package:reafy/provider/auth_provider.dart';
import 'package:reafy/provider/expense_provider.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/shared_widgets/buttons/primary_button.dart';
import 'package:reafy/shared_widgets/buttons/secondary_button.dart';
import 'package:reafy/shared_widgets/reafy_appbar.dart';
import 'package:reafy/shared_widgets/reafy_nav_footer.dart';
import 'package:reafy/views/new_expense_template/new_expense_template_view.dart';
import 'package:reafy/views/select_expense_template/widgets/select_expense_template_card.dart';

class SelectExpenseTemplateView extends StatefulWidget {
  const SelectExpenseTemplateView({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectExpenseTemplateView> createState() =>
      _SelectExpenseTemplateView();
}

class _SelectExpenseTemplateView extends State<SelectExpenseTemplateView> {
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final expenseProvider =
        Provider.of<ExpenseProvider>(context, listen: false);
    expenseProvider.getExpenseTemplates(authProvider.reafyUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReafyAppBar(),
      body:
          Consumer<ExpenseProvider>(builder: (context, expenseProvider, child) {
        return expenseProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      "Choose expense template",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                        child: ListView.builder(
                            itemCount: expenseProvider
                                .expenseTemplates.templates!.length,
                            itemBuilder: ((context, index) =>
                                SelectExpenseTemplateCard(
                                    expenseTemplate: expenseProvider
                                        .expenseTemplates.templates![index])))),
                  ],
                ),
              ));
      }),
      floatingActionButton: ReafyNavFooter(
        backText: "Back",
        backOnPressed: () => {Navigator.pop(context)},
        forwardText: "New template",
        forwardOnPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProxyProvider<AuthProvider,
                        ExpenseTemplateProvider>(
                      create: (BuildContext context) => ExpenseTemplateProvider(
                          Provider.of<AuthProvider>(context, listen: false)),
                      update: (BuildContext context,
                              AuthProvider authProvider,
                              ExpenseTemplateProvider?
                                  expenseTemplateProvider) =>
                          ExpenseTemplateProvider(authProvider),
                      child: const NewExpenseTemplateView(),
                    )),
          )
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
