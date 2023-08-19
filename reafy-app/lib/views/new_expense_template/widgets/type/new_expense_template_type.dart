import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/shared_widgets/buttons/primary_button.dart';
import 'package:reafy/shared_widgets/reafy_nav_footer.dart';
import 'package:reafy/views/new_expense_template/widgets/type/new_expense_template_type_radio_group.dart';

class NewExpenseTemplateType extends StatelessWidget {
  const NewExpenseTemplateType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseTemplateProvider>(
        builder: (context, expenseTemplateProvider, child) {
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Expense Type",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                const NewExpenseTemplateTypeRadioGroup()
              ],
            ),
            ReafyNavFooter(
                backText: "Back",
                forwardText: "Next",
                backOnPressed: () => expenseTemplateProvider
                    .updateStateStep(NewExpenseTemplateStateEnum.intent),
                forwardOnPressed: () => expenseTemplateProvider
                    .updateStateStep(NewExpenseTemplateStateEnum.overview))
          ]));
    });
  }
}
