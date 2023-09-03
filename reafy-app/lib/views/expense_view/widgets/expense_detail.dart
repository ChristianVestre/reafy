import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/expense_provider.dart';
import 'package:reafy/shared_widgets/buttons/primary_button.dart';
import 'package:reafy/shared_widgets/buttons/secondary_button.dart';
import 'package:reafy/theme/colors.dart';
import 'package:reafy/views/expense_view/widgets/expense_line_item.dart';
import 'package:reafy/views/expense_view/widgets/expense_meta_info.dart';
import 'package:reafy/views/select_expense_template/select_expense_template.dart';

class ExpenseDetail extends StatelessWidget {
  const ExpenseDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
        builder: (context, expenseProvider, child) {
      return Column(children: [
        Container(
            margin: const EdgeInsets.only(top: 16),
            child: Text(
              "New Expense",
              style: Theme.of(context).textTheme.titleMedium,
            )),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 0.5, color: Theme.of(context).borderColor),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: Column(children: [
              Text(
                expenseProvider.expense.establishmentName!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(" 31.05.23",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 24),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: expenseProvider.expense.lineItems!.length,
                  itemBuilder: ((context, index) => ExpenseLineItem(
                      item: expenseProvider!.expense!.lineItems![index]))),
              const ExpenseMetaInfo(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ReafySecondaryButton(text: "Deny", onPressed: () => {}),
                  ReafyPrimaryButton(
                      text: "Accept",
                      onPressed: () => {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SelectExpenseTemplateView(),
                              ),
                            )
                          })
                ],
              )
            ]))),
      ]);
    });
  }
}
