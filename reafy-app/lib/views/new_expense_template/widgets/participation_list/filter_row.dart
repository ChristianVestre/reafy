import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/shared_widgets/buttons/reafy_filter_button.dart';
import 'package:reafy/views/new_expense_template/widgets/participation_list/company_dialog.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseTemplateProvider>(
        builder: (context, expenseTemplateProvider, child) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              height: 40,
              child: ReafyFilterButton(
                text: "Companies",
                active: expenseTemplateProvider.searchFilter ==
                        NewExpenseTemplateSearchFilterEnum.company
                    ? false
                    : true,
                onPressed: () =>
                    {companyDialog(context, expenseTemplateProvider)},
                onActivePressed: () =>
                    {expenseTemplateProvider.resetSearchResult()},
              )),
          /*  Expanded(
              child: ReafyFilterButton(
            text: "Personal",
            active: expenseTemplateProvider.searchFilter ==
                    NewExpenseTemplateSearchFilterEnum.personal
                ? false
                : true,
            onPressed: () => {},
            onActivePressed: () => {},
          )),
          Expanded(
              child: ReafyFilterButton(
            text: "Partners",
            active: expenseTemplateProvider.searchFilter ==
                    NewExpenseTemplateSearchFilterEnum.personal
                ? false
                : true,
            onPressed: () => {},
            onActivePressed: () => {},
          )),*/
        ]),
      );
    });
  }
}
