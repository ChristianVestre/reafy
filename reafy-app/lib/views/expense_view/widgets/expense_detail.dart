import 'package:flutter/material.dart';
import 'package:reafy/theme/colors.dart';
import 'package:reafy/views/expense_view/widgets/expense_line_item.dart';

final items = ["Test 1", "test 2", "test 3"];

class ExpenseDetail extends StatelessWidget {
  const ExpenseDetail({super.key, this.data});

  final data;

  @override
  Widget build(BuildContext context) {
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
              border:
                  Border.all(width: 0.5, color: Theme.of(context).borderColor),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
              child: Column(children: [
            Text(
              "Mesh Youngstorget",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(" 31.05.23",
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 24),
            ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: ((context, index) =>
                    ExpenseLineItem(item: items[index]))),
          ])))
    ]);
  }
}
