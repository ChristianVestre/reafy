import 'package:flutter/material.dart';
import 'package:reafy/theme/colors.dart';
import 'package:reafy/views/expense_view/widgets/expense_line_item.dart';

class NoExpense extends StatelessWidget {
  const NoExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 80,
      ),
      Container(
          margin: const EdgeInsets.all(16),
          child: Text(
            "You have no expenses to deal with.",
            style: Theme.of(context).textTheme.headlineMedium,
          ))
    ]);
  }
}
