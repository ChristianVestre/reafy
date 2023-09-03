import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/theme/colors.dart';

class NewExpenseTemplateTypeRadioGroup extends StatelessWidget {
  const NewExpenseTemplateTypeRadioGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseTemplateProvider>(
        builder: (context, expenseTemplateProvider, child) {
      return Container(
          decoration: BoxDecoration(
              border:
                  Border.all(width: 0.5, color: Theme.of(context).borderColor),
              borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(children: [
                Transform.scale(
                    scale: 1.2,
                    child: Radio<ExpenseTemplateTypeEnum>(
                        activeColor: const Color(0xFFD499B9),
                        value: ExpenseTemplateTypeEnum
                            .ikkeFradragsberettigetRepresentasjon,
                        groupValue: expenseTemplateProvider
                            .expenseTemplateState.tempData!.type,
                        onChanged: (ExpenseTemplateTypeEnum? value) =>
                            {expenseTemplateProvider.updateType(value!)})),
                const SizedBox(width: 8),
                Text("Ikke fradragsberettiget representasjon",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize)),
              ]),
              const SizedBox(height: 4),
              Row(children: [
                Transform.scale(
                    scale: 1.2,
                    child: Radio<ExpenseTemplateTypeEnum>(
                        activeColor: const Color(0xFFD499B9),
                        value: ExpenseTemplateTypeEnum
                            .fradragsberettigetRepresentasjon,
                        groupValue: expenseTemplateProvider
                            .expenseTemplateState.tempData!.type,
                        onChanged: (ExpenseTemplateTypeEnum? value) =>
                            {expenseTemplateProvider.updateType(value!)})),
                const SizedBox(width: 8),
                Text("Fradragsberettiget representasjon",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize)),
              ]),
              const SizedBox(height: 4),
              Row(children: [
                Transform.scale(
                    scale: 1.2,
                    child: Radio<ExpenseTemplateTypeEnum>(
                        activeColor: const Color(0xFFD499B9),
                        value: ExpenseTemplateTypeEnum.velferd,
                        groupValue: expenseTemplateProvider
                            .expenseTemplateState.tempData!.type,
                        onChanged: (ExpenseTemplateTypeEnum? value) =>
                            {expenseTemplateProvider.updateType(value!)})),
                const SizedBox(width: 8),
                Text(
                  "Velferd",
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium!.fontSize),
                ),
              ]),
            ],
          ));
    });
  }
}
