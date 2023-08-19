import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/shared_widgets/reafy_nav_footer.dart';
import 'package:reafy/shared_widgets/reafy_text_field.dart';
import 'package:reafy/theme/colors.dart';

class NewExpenseTemplateIntent extends StatelessWidget {
  const NewExpenseTemplateIntent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseTemplateProvider>(
        builder: (context, expenseTemplateProvider, child) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Intent",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  InputDecorator(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Theme.of(context).lightGray))),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<NewExpenseTemplateIntentEnum>(
                              borderRadius: BorderRadius.circular(5),
                              value: expenseTemplateProvider
                                  .expenseTemplateState.tempData!.intent,
                              elevation: 2,
                              style: const TextStyle(color: Colors.black),
                              onChanged: (NewExpenseTemplateIntentEnum? value) {
                                expenseTemplateProvider.updateIntent(value!);
                              },
                              items: NewExpenseTemplateIntentEnum.values.map<
                                      DropdownMenuItem<
                                          NewExpenseTemplateIntentEnum>>(
                                  (NewExpenseTemplateIntentEnum value) {
                                return DropdownMenuItem<
                                    NewExpenseTemplateIntentEnum>(
                                  value: value,
                                  child: Text(value.stringValues),
                                );
                              }).toList()))),
                  const SizedBox(
                    height: 32,
                  ),
                  if (expenseTemplateProvider
                          .expenseTemplateState.tempData!.intent ==
                      NewExpenseTemplateIntentEnum.other)
                    Column(
                      children: [
                        const Text(
                          "Please specify the intent of the expense",
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ReafyTextField(
                          controller: expenseTemplateProvider
                              .expenseTemplateState.otherIntentController,
                          onChanged: (value) => expenseTemplateProvider
                              .updateSearchResultWithParticipant(value),
                          hintText: "Intent",
                        )
                      ],
                    ),
                ],
              ),
              ReafyNavFooter(
                  backText: "Back",
                  forwardText: "Next",
                  backOnPressed: () => expenseTemplateProvider
                      .updateStateStep(NewExpenseTemplateStateEnum.list),
                  forwardOnPressed: () => expenseTemplateProvider
                      .updateStateStep(NewExpenseTemplateStateEnum.type))
            ]),
      );
    });
  }
}
