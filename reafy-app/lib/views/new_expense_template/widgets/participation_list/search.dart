import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/shared_widgets/reafy_text_field.dart';
import 'package:reafy/theme/colors.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseTemplateProvider>(
        builder: (context, expenseTemplateProvider, child) {
      return Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: ReafyTextField(
            onChanged: (value) => expenseTemplateProvider
                .updateSearchResultWithParticipant(value),
            controller:
                expenseTemplateProvider.expenseTemplateState.searchQuery,
            hintText: "Search",
          ));
    });
  }
}
