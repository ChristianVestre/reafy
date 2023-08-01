import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/theme/colors.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseTemplateProvider>(
        builder: (context, expenseTemplateProvider, child) {
      return Container(
        padding: EdgeInsets.all(16),
        child: TextField(
            decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Theme.of(context).borderColor),
                filled: true,
                fillColor: Theme.of(context).lightGray,
                focusColor: Theme.of(context).borderColor,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(5),
                ),
                border: const OutlineInputBorder(
                    gapPadding: 0, borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.all(8),
                isDense: true),
            cursorColor: Theme.of(context).borderColor,
            style: Theme.of(context).textTheme.bodyLarge,
            controller:
                expenseTemplateProvider.expenseTemplateState.searchQuery,
            onChanged: (value) => expenseTemplateProvider
                .updateNewExpenseTemplateSearchResult(value)),
      );
    });
  }
}
